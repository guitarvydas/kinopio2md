package kinopio2md

import zd "../0d/0d/odin/0d"
import "../0d/0d/odin/std"

main :: proc() {
    main_container_name,  diagram_names := std.parse_command_line_args ()
    palette := std.initialize_component_palette (diagram_names, components_to_include_in_project)
    std.run (&palette, main_container_name, diagram_names, inject)
}

inject :: proc (main_container : ^zd.Eh) {
    p := zd.new_datum_string ("softwareAtomsTest.json") // from Kinopio 'software atoms test' https://kinopio.club/software-atoms-test-FhzG4AniDsQj1ilz2N7FA
    std.dump_hierarchy (main_container)
    msg := zd.make_message("filename", p, zd.make_cause (main_container, nil) )
    main_container.handler(main_container, msg)
}


components_to_include_in_project :: proc (leaves: ^[dynamic]zd.Leaf_Template) {
    zd.append_leaf (leaves, std.string_constant ("Word"))
    zd.append_leaf (leaves, std.string_constant ("word.ohm"))
    zd.append_leaf (leaves, std.string_constant ("word.sem.js"))

    zd.append_leaf (leaves, std.string_constant ("KinopioCards"))
    zd.append_leaf (leaves, std.string_constant ("cards.ohm"))
    zd.append_leaf (leaves, std.string_constant ("cards.rwr"))
    zd.append_leaf (leaves, std.string_constant ("support.js"))
    zd.append_leaf (leaves, std.string_constant ("content.pl"))

    zd.append_leaf (leaves, std.string_constant ("Escapes"))
    zd.append_leaf (leaves, std.string_constant ("escapes.ohm"))
    zd.append_leaf (leaves, std.string_constant ("escapes.rwr"))
    zd.append_leaf (leaves, std.string_constant ("escapessupport.js"))
}

