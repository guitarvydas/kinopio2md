package kinopio2md

import "0d"
import "std"

main :: proc() {

    /* log_level := zd.log_handlers // set this to only track handlers in Components */
    /* //log_level := zd.log_all // set this to track everything, equivalent to runtime.Logger_Level.Debug */
    /* // log_level := runtime.Logger_Level.Info */
    /* fmt.printf ("\n*** starting logger level %v ***\n", log_level) */
    /* context.logger = log.create_console_logger( */
    /* 	lowest=cast(runtime.Logger_Level)log_level, */
    /*     opt={.Level, .Time, .Terminal_Color}, */
    /* ) */

    diagram_name, main_container_name := std.parse_command_line_args ("<specify on command line>", "main")
    palette := std.initialize_component_palette (diagram_name, components_to_include_in_project)
    std.run (&palette, main_container_name, diagram_name, start_function)
}

project_specific_components :: proc (leaves: ^[dynamic]zd.Leaf_Template) {
}

inject :: proc (main_container : ^zd.Eh) {

    p := zd.new_datum_string ("kjson/softwareAtomsTest.json") // from Kinopio 'software atoms test' https://kinopio.club/software-atoms-test-FhzG4AniDsQj1ilz2N7FA
    msg := zd.make_message("filename", p, zd.make_cause (main_container, nil) )
    main_container.handler(main_container, msg)
}


components_to_include_in_project :: proc (leaves: ^[dynamic]zd.Leaf_Template) {
    zd.append_leaf (&leaves, string_constant ("Word"))
    zd.append_leaf (&leaves, string_constant ("word.ohm"))
    zd.append_leaf (&leaves, string_constant ("word.sem.js"))

    zd.append_leaf (&leaves, string_constant ("KinopioCards"))
    zd.append_leaf (&leaves, string_constant ("cards.ohm"))
    zd.append_leaf (&leaves, string_constant ("cards.rwr"))
    zd.append_leaf (&leaves, string_constant ("support.js"))
    zd.append_leaf (&leaves, string_constant ("content.pl"))

    zd.append_leaf (&leaves, string_constant ("Escapes"))
    zd.append_leaf (&leaves, string_constant ("escapes.ohm"))
    zd.append_leaf (&leaves, string_constant ("escapes.rwr"))
    zd.append_leaf (&leaves, string_constant ("escapessupport.js"))
}

