:- use_module(library(http/json)).

main :-
    json_read(user_input, JSON),
    json_write(user_output, JSON).

    
