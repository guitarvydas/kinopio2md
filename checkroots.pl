

is_child(ID) :-
    connection(_,ID,_).
is_root(ID) :-
    text(ID,_),
    \+is_child(ID).


main :-
    consult(content),
    forall(is_root(ID),print_root_only(ID)),
    halt.

print_root_only(ID) :-
    is_root(ID),
    print_root_text(ID).
print_root_only(ID) :-
    is_root(ID),
    \+connection(ID,_,_),
    print_root_text(ID).
print_root_text(ID):-
    text(ID,Text),
    write(ID),write('...'),
    write(Text),
    nl.
