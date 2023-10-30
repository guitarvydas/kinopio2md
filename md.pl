text('8amuHptsj11UlfGwDM5Et','T').
text('3zLaUVBx3pUtRqiQOVCr4','U').
text('l3C8sczlzjbvLFLmmMBqE','X').
text('lQvKy_hiolqibmb7BZ3vz','V').
text('-f4AWj9xIn7dTLv7YSSSr','Y').
text('esbPehRs8ubCbSUDeWf_M','W').
text('d823RC6LcljEzjzSSwyE8','Z').
text('RPBNnXq8PZAG_OIo50tRS','N').
text('KhA8q_UyjDMguM6Y2hPrc','M').
connection('8amuHptsj11UlfGwDM5Et','3zLaUVBx3pUtRqiQOVCr4','QtiZbof3vqGX8J0jK6-tw').
connection('8amuHptsj11UlfGwDM5Et','l3C8sczlzjbvLFLmmMBqE','QtiZbof3vqGX8J0jK6-tw').
connection('3zLaUVBx3pUtRqiQOVCr4','lQvKy_hiolqibmb7BZ3vz','QtiZbof3vqGX8J0jK6-tw').
connection('l3C8sczlzjbvLFLmmMBqE','-f4AWj9xIn7dTLv7YSSSr','QtiZbof3vqGX8J0jK6-tw').
connection('lQvKy_hiolqibmb7BZ3vz','esbPehRs8ubCbSUDeWf_M','QtiZbof3vqGX8J0jK6-tw').
connection('esbPehRs8ubCbSUDeWf_M','d823RC6LcljEzjzSSwyE8','BWmozYfhcWgTPlzgLAbL1').
connection('lQvKy_hiolqibmb7BZ3vz','RPBNnXq8PZAG_OIo50tRS','8Zdh33bp2dA1mYgIyI8l1').
connection('RPBNnXq8PZAG_OIo50tRS','KhA8q_UyjDMguM6Y2hPrc','8Zdh33bp2dA1mYgIyI8l1').


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
    forall(is_root(ID),print_root(ID)).
