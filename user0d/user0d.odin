package user0d

import "core:fmt"

import reg "../registry0d"
import zd "../0d"
import leaf "../leaf0d"

start_logger :: proc () -> bool {
    return true
}

components :: proc (leaves: ^[dynamic]reg.Leaf_Template) {
    append(leaves, reg.Leaf_Template { name = "1then2", instantiate = leaf.deracer_instantiate })
    append(leaves, reg.Leaf_Template { name = "?", instantiate = leaf.probe_instantiate })
    append(leaves, reg.Leaf_Template { name = "trash", instantiate = leaf.trash_instantiate })

    // for ohmjs
    append(leaves, reg.Leaf_Template { name = "HardCodedGrammar", instantiate = leaf.hard_coded_rwr_grammar_instantiate })
    append(leaves, reg.Leaf_Template { name = "HardCodedSemantics", instantiate = leaf.hard_coded_rwr_semantics_instantiate })
    append(leaves, reg.Leaf_Template { name = "HardCodedSupport", instantiate = leaf.hard_coded_rwr_support_instantiate })
    append(leaves, reg.Leaf_Template { name = "Bang", instantiate = leaf.bang_instantiate })
    append(leaves, reg.Leaf_Template { name = "concat", instantiate = leaf.concat_instantiate })
    append(leaves, reg.Leaf_Template { name = "OhmJS", instantiate = leaf.ohmjs_instantiate })

    // for RT front end
    append(leaves, reg.Leaf_Template { name = "'Word'", instantiate = leaf.word_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/word.ohm'", instantiate = leaf.wordohm_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/word.sem.js'", instantiate = leaf.wordjs_instantiate })

    append(leaves, reg.Leaf_Template { name = "'RWR'", instantiate = leaf.rwr_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rwr/rwr.ohm'", instantiate = leaf.rwrohm_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rwr/rwr.sem.js'", instantiate = leaf.rwrsemjs_instantiate })

    append(leaves, reg.Leaf_Template { name = "'Escapes'", instantiate = leaf.escapes_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/escapes.ohm'", instantiate = leaf.escapesohm_instantiate })
    append(leaves, reg.Leaf_Template { name = "'rt/escapes.rwr'", instantiate = leaf.escapesrwr_instantiate })
    
    append(leaves, reg.Leaf_Template { name = "fakepipename", instantiate = leaf.fakepipename_instantiate })
    append(leaves, reg.Leaf_Template { name = "syncfilewrite2", instantiate = leaf.syncfilewrite2_instantiate })
}



