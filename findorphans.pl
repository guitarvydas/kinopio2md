orphan_check(ID):-
    connection(Parent,ID,_), % keep this line, although it is redundant - Prolog requires a +ve match before the next line
    \+text(ID,_),
    !,
    write('[101m'),
    write('ORPHAN: no text for node '), write(ID), 
    write('[0m'),
    writeParent(Parent),
    nl.
orphan_check(ID):-
    connection(_,ID,_), % keep this line, although it is redundant - Prolog requires a +ve match before the next line
    text(ID,_),
    !.

writeParent(Parent) :-
    text(Parent,Ptext),
    !,
    write(' with parent text: '), write('"'), write(Ptext), write('"').

writeParent(Parent) :-
    write(' with parent (no text) '), write(Parent).

main :-
    consult(content),
    forall(connection(_,ID,_),orphan_check(ID)),
    halt.
repl :-
    consult(content),
    forall(connection(_,ID,_),orphan_check(ID)).

