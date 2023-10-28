package leaf0d

import "core:fmt"
import "core:runtime"
import "core:log"
import "core:strings"
import "core:slice"
import "core:os"
import "core:unicode/utf8"

import reg "../registry0d"
import "../process"
import "../syntax"
import zd "../0d"

gensym :: proc (s : string) -> string {
    @(static) counter := 0
    counter += 1
    name_with_id := fmt.aprintf("%s◦%d", s, counter)
    return name_with_id
}


stdout_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    return zd.make_leaf(name, owner, nil, stdout_handle)
}

stdout_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    fmt.printf("%#v", msg.datum)
}

process_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    command_string := strings.clone(strings.trim_left(name, "$ "))
    command_string_ptr := new_clone(command_string)
    return zd.make_leaf(name, owner, command_string_ptr^, process_handle)
}

process_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    
    utf8_string :: proc(bytes: []byte) -> (s: string, ok: bool) {
        s = string(bytes)
        ok = utf8.valid_string(s)
        return
    }
    
    send_output :: proc(eh: ^zd.Eh, port: string, output: []byte, causingMsg: ^zd.Message) {
        if len(output) > 0 {
            str, ok := utf8_string(output)
            if ok {
                zd.send_string (eh, port, str, causingMsg)
            } else {
                zd.send (eh, port, zd.new_datum_bytes (output), causingMsg)
            }
        }
    }

    switch msg.port {
    case "stdin":
        handle := process.process_start(eh.instance_data.(string))
        defer process.process_destroy_handle(handle)

        // write input, wait for finish
        {
            switch value in msg.datum.data {
            case string:
                bytes := transmute([]byte)value
                os.write(handle.input, bytes)
            case []byte:
                os.write(handle.input, value)
            case zd.Bang:
                // OK, no input, just run it
	    case:
                log.errorf("%s: Shell leaf input can handle string, bytes, or bang (got: %v)", eh.name, value.id)
            }
            os.close(handle.input)
            process.process_wait(handle)
        }

        // breaks bootstrap error check, thus, removed line: zd.send_string (eh, "done", Bang{})

        // stdout handling
        {
            stdout, ok := process.process_read_handle(handle.output)
            if ok {
                send_output(eh, "stdout", stdout, msg)
            }
        }

        // stderr handling
        {
            stderr, ok := process.process_read_handle(handle.error)
            if ok {
                send_output(eh, "stderr", stderr, msg)
            }

            if len(stderr) > 0 {
                str := string(stderr)
                str = strings.trim_right_space(str)
                log.error(str)
            }
        }
    }
}

collect_process_leaves :: proc(path: string, leaves: ^[dynamic]reg.Leaf_Instantiator) {
    ref_is_container :: proc(decls: []syntax.Container_Decl, name: string) -> bool {
        for d in decls {
            if d.name == name {
                return true
            }
        }
        return false
    }

    decls, err := syntax.parse_drawio_mxgraph(path)
    assert(err == nil)
    defer delete(decls)

    // TODO(z64): while harmless, this doesn't ignore duplicate process decls yet.

    for decl in decls {
        for child in decl.children {
            if ref_is_container(decls[:], child.name) {
                continue
            }

            if strings.has_prefix(child.name, "$") {
                leaf_instantiate := reg.Leaf_Instantiator {
                    name = child.name,
                    instantiate = process_instantiate,
                }
                append(leaves, leaf_instantiate)
            }
        }
    }
}

////

Command_Instance_Data :: struct {
    buffer : string
}

command_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("command")
    instp := new (Command_Instance_Data)
    return zd.make_leaf (name_with_id, owner, instp^, command_handle)
}

command_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := eh.instance_data.(Command_Instance_Data)
    switch msg.port {
    case "command":
        inst.buffer = msg.datum.data.(string)
        received_input := msg.datum.data.(string)
        captured_output, _ := process.run_command (inst.buffer, received_input)
        zd.send_string (eh, "stdout", captured_output, msg)
	case:
        fmt.assertf (false, "!!! ERROR: command got an illegal message port %v", msg.port)
    }
}

icommand_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("icommand[%d]")
    instp := new (Command_Instance_Data)
    return zd.make_leaf (name_with_id, owner, instp^, icommand_handle)
}

icommand_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := eh.instance_data.(Command_Instance_Data)
    switch msg.port {
    case "command":
        inst.buffer = msg.datum.data.(string)
    case "stdin":
        received_input := msg.datum.data.(string)
        captured_output, _ := process.run_command (inst.buffer, received_input)
        zd.send_string (eh, "stdout", captured_output, msg)
	case:
        fmt.assertf (false, "!!! ERROR: command got an illegal message port %v", msg.port)
    }
}


TwoMessages :: struct {
    first : ^zd.Message,
    second : ^zd.Message
}


Deracer_States :: enum { idle, waitingForFirst, waitingForSecond }

Deracer_Instance_Data :: struct {
    state : Deracer_States,
    buffer : TwoMessages
}

reclaim_Buffers_from_heap :: proc (inst : ^Deracer_Instance_Data) {
    zd.destroy_message (inst.buffer.first)
    zd.destroy_message (inst.buffer.second)
}

deracer_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym ("deracer")
    inst := new (Deracer_Instance_Data) // allocate in the heap
    inst.state = .idle
    eh := zd.make_leaf (name_with_id, owner, inst^, deracer_handle)
    return eh
}

send_first_then_second :: proc (eh : ^zd.Eh, inst: ^Deracer_Instance_Data) {
    zd.forward (eh, "1", inst.buffer.first)
    zd.forward (eh, "2", inst.buffer.second)
    reclaim_Buffers_from_heap (inst)
}

deracer_handle :: proc(eh: ^zd.Eh,  msg: ^zd.Message) {
    inst := &eh.instance_data.(Deracer_Instance_Data)
    switch (inst.state) {
    case .idle:
        switch msg.port {
        case "1":
            inst.buffer.first = msg
            inst.state = .waitingForSecond
        case "2":
            inst.buffer.second = msg
            inst.state = .waitingForFirst
        case:
            fmt.assertf (false, "bad msg.port A for deracer %v\n", msg.port)
        }
    case .waitingForFirst:
        switch msg.port {
        case "1":
            inst.buffer.first = msg
            send_first_then_second (eh, inst)
            inst.state = .idle
        case:
            fmt.assertf (false, "bad msg.port B for deracer %v\n", msg.port)
        }
    case .waitingForSecond:
        switch msg.port {
        case "2":
            inst.buffer.second = msg
            send_first_then_second (eh, inst)
            inst.state = .idle
        case:
            fmt.assertf (false, "bad msg.port C for deracer %v\n", msg.port)
        }
    case:
        fmt.assertf (false, "bad state for deracer %v\n", eh.state)
    }
}

/////////

probe_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("?")
    return zd.make_leaf (name_with_id, owner, nil, probe_handle)
}

probe_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    fmt.eprintln (eh.name, msg.datum.asString (msg.datum))
}

trash_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("trash")
    return zd.make_leaf (name_with_id, owner, nil, trash_handle)
}

trash_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    // to appease dumped-on-floor checker
}

////////

OhmJS_Instance_Data :: struct {
    grammarname : string, // grammar name
    grammarfilename : string, // file name of grammar in ohm-js format
    semanticsfilename : string, // file name of source text of semantics support code JavaScript namespace
    input : string, // source file to be parsed
}

ohmjs_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("OhmJS")
    inst := new (OhmJS_Instance_Data) // all fields have zero value before any messages are received
    return zd.make_leaf (name_with_id, owner, inst^, ohmjs_handle)
}

ohmjs_maybe :: proc (eh: ^zd.Eh, inst: ^OhmJS_Instance_Data, causingMsg: ^zd.Message) {
    if "" != inst.grammarname && "" != inst.grammarfilename && "" != inst.semanticsfilename && "" != inst.input {

        cmd := fmt.aprintf ("ohmjs/ohmjs.js %s %s %s", inst.grammarname, inst.grammarfilename, inst.semanticsfilename)
	captured_output, err := process.run_command (cmd, inst.input)
        zd.send_string (eh, "output", strings.trim_space (captured_output), causingMsg)
	zd.send_string (eh, "error", strings.trim_space (err), causingMsg)
	fmt.printf ("ohmjs_maybe: %v\n", cmd) //, strings.trim_space (err))
    }
}

ohmjs_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := &eh.instance_data.(OhmJS_Instance_Data)
    switch (msg.port) {
    case "grammar name":
	inst.grammarname = strings.clone (msg.datum.data.(string))
	ohmjs_maybe (eh, inst, msg)
    case "grammar":
	inst.grammarfilename = strings.clone (msg.datum.data.(string))
	ohmjs_maybe (eh, inst, msg)
    case "semantics":
	inst.semanticsfilename = strings.clone (msg.datum.data.(string))
	ohmjs_maybe (eh, inst, msg)
    case "input":
	inst.input = strings.clone (msg.datum.data.(string))
	ohmjs_maybe (eh, inst, msg)
	case:
        emsg := fmt.aprintf("!!! ERROR: OhmJS got an illegal message port %v", msg.port)
	zd.send_string (eh, "error", emsg, msg)
    }
}

////

/// RWR rewriter generates semantics from .rwr spec

rwr_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("rwr")
    return zd.make_leaf (name_with_id, owner, nil, rwr_handle)
}
rwr_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "RWR", msg)
}
rwrohm_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("rwrohm")
    return zd.make_leaf (name_with_id, owner, nil, rwrohm_handle)
}
rwrohm_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rwr/rwr.ohm", msg)
}
rwrsemjs_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("rwrsemjs")
    return zd.make_leaf (name_with_id, owner, nil, rwrsemjs_handle)
}
rwrsemjs_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rwr/rwr.sem.js", msg)
}

///

fakepipename_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("fakepipename")
    return zd.make_leaf (name_with_id, owner, nil, fakepipename_handle)
}

fakepipename_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    @(static) rand := 0
    rand += 1
    zd.send_string (eh, "output", fmt.aprintf ("/tmp/fakepipename%d", rand), msg)
}

///



rwr_grammar := ""
rwr_semobject := ""
rwr_support_js := ""

hard_coded_rwr_grammar_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("hard_coded_rwr_grammar")
    return zd.make_leaf (name_with_id, owner, nil, hard_coded_rwr_grammar_handle)
}

hard_coded_rwr_semantics_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("hard_coded_rwr_semantics")
    return zd.make_leaf (name_with_id, owner, nil, hard_coded_rwr_semantics_handle)
}

hard_coded_rwr_support_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("hard_coded_rwr_support")
    return zd.make_leaf (name_with_id, owner, nil, hard_coded_rwr_support_handle)
}

hard_coded_rwr_grammar_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", rwr_grammar, msg)
}
hard_coded_rwr_semantics_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", rwr_semobject, msg)
}
hard_coded_rwr_support_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", rwr_support_js, msg)
}

///
bang_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("bang[%d]")
    return zd.make_leaf (name_with_id, owner, nil, bang_handle)
}

bang_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send (eh, "output", zd.new_datum_bang (), msg)
}

///
Concat_Instance_Data :: struct {
    buffer : string,
}

empty_string := ""

concat_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("concat")
    instp := new (Concat_Instance_Data)
    instp.buffer = strings.clone (empty_string)
    return zd.make_leaf (name_with_id, owner, instp^, concat_handle)
}

concat_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := &eh.instance_data.(Concat_Instance_Data)
    switch (msg.port) {
    case "str":
	delete (inst.buffer)
	inst.buffer = fmt.aprintf ("%s%s", inst.buffer, msg.datum.data.(string))
    case "flush":
	zd.send_string (eh, "str", inst.buffer, msg)
	delete (inst.buffer)
	inst.buffer = ""
    }
}

////////

////

word_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("word")
    return zd.make_leaf (name_with_id, owner, nil, word_handle)
}

word_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "Word", msg)
}


wordohm_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("word")
    return zd.make_leaf (name_with_id, owner, nil, wordohm_handle)
}

wordohm_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rt/word.ohm", msg)
}

wordjs_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("wordjs")
    return zd.make_leaf (name_with_id, owner, nil, wordjs_handle)
}

wordjs_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rt/word.sem.js", msg)
}

////////

escapes_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("escapes")
    return zd.make_leaf (name_with_id, owner, nil, escapes_handle)
}
escapes_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "Escapes", msg)
}
escapesohm_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("escapesohm")
    return zd.make_leaf (name_with_id, owner, nil, escapesohm_handle)
}
escapesohm_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rt/escapes.ohm", msg)
}
escapesrwr_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("escapesrwr")
    return zd.make_leaf (name_with_id, owner, nil, escapesrwr_handle)
}
escapesrwr_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    zd.send_string (eh, "output", "rt/escapes.rwr", msg)
}

////////

Syncfilewrite_Data :: struct {
    filename : string
}

syncfilewrite_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("syncfilewrite")
    instp := new (Syncfilewrite_Data)
    return zd.make_leaf (name_with_id, owner, instp^, syncfilewrite_handle)
}

syncfilewrite_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := &eh.instance_data.(Syncfilewrite_Data)
    switch msg.port {
    case "filename":
	inst.filename = msg.datum.data.(string)
    case "stdin":
	contents := msg.datum.data.(string)
	ok := os.write_entire_file (inst.filename, transmute([]u8)contents, true)
	if !ok {
	    zd.send_string (eh, "stderr", "write error", msg)
	}
    }
}

// temp copy for bootstrap, sends "done" (error during bootstrap if not wired)

syncfilewrite2_instantiate :: proc(name: string, owner : ^zd.Eh) -> ^zd.Eh {
    name_with_id := gensym("syncfilewrite2")
    inst := new (Syncfilewrite_Data)
    return zd.make_leaf (name_with_id, owner, inst^, syncfilewrite2_handle)
}

syncfilewrite2_handle :: proc(eh: ^zd.Eh, msg: ^zd.Message) {
    inst := &eh.instance_data.(Syncfilewrite_Data)
    switch msg.port {
    case "filename":
	inst.filename = msg.datum.data.(string)
    case "input":
	contents := msg.datum.data.(string)
	ok := os.write_entire_file (inst.filename, transmute([]u8)contents, true)
	if !ok {
	    zd.send_string (eh, "error", "write error", msg)
	} else {
	    zd.send (eh, "done", zd.new_datum_bang (), msg)
	}
    }
}

