is_child(ID) :-
    connection(_,ID,_).
is_root(ID) :-
    text(ID,_),
    \+is_child(ID).

print_indent(N):-
    N \= 0,
    write('    '),
    succ(M,N),
    print_indent(M).
print_indent(N) :-
    N = 0.

print_text(ID,IndentLevel):-
    text(ID,Text),
    print_indent(IndentLevel),
    write(Text),
    nl.

print_dash_text(ID,IndentLevel):-
    text(ID,Text),
    print_indent(IndentLevel),
    write('- '),
    write(Text),
    nl.

print_root(ID) :-
    is_root(ID),
    print_node(ID,0),
    forall(connection(ID,Child,_),print_tree(Child,0)).
print_root(ID) :-
    is_root(ID),
    \+connection(ID,_,_),
    print_node(ID,0).

print_node(ID,Level):-
    print_text(ID,Level).

print_dash_node(ID,Level):-
    print_dash_text(ID,Level).

print_tree(ID,Level):-
    text(ID,_),
    print_dash_node(ID,Level),
    succ(Level,NextLevel),
    forall(connection(ID,Child,_),print_tree(Child,NextLevel)).
print_tree(ID,Level):-
    text(ID,_),
    \+connection(ID,_,_),
    print_dash_node(ID,Level).

main :-
    consult(content),
    forall(is_root(ID),print_root(ID)),
    halt.
