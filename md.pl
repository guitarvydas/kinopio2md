text('8amuHptsj11UlfGwDM5Et','T').
text('3zLaUVBx3pUtRqiQOVCr4','U').
text('l3C8sczlzjbvLFLmmMBqE','X').
text('lQvKy_hiolqibmb7BZ3vz','V').
text('-f4AWj9xIn7dTLv7YSSSr','Y').
text('esbPehRs8ubCbSUDeWf_M','W').
text('d823RC6LcljEzjzSSwyE8','Z').
connection('8amuHptsj11UlfGwDM5Et','3zLaUVBx3pUtRqiQOVCr4','QtiZbof3vqGX8J0jK6-tw').
connection('8amuHptsj11UlfGwDM5Et','l3C8sczlzjbvLFLmmMBqE','QtiZbof3vqGX8J0jK6-tw').
connection('3zLaUVBx3pUtRqiQOVCr4','lQvKy_hiolqibmb7BZ3vz','QtiZbof3vqGX8J0jK6-tw').
connection('l3C8sczlzjbvLFLmmMBqE','-f4AWj9xIn7dTLv7YSSSr','QtiZbof3vqGX8J0jK6-tw').
connection('lQvKy_hiolqibmb7BZ3vz','esbPehRs8ubCbSUDeWf_M','QtiZbof3vqGX8J0jK6-tw').
connection('esbPehRs8ubCbSUDeWf_M','d823RC6LcljEzjzSSwyE8','BWmozYfhcWgTPlzgLAbL1').

is_child(ID) :-
    connection(_,ID,_).
is_root(ID) :-
    text(ID,_),
    \+is_child(ID).

print_text(ID,IndentLevel):-
    text(ID,Text),
    write(IndentLevel),
    write(' '),
    write(Text),
    nl.

print_root(ID) :-
    is_root(ID),
    connection(ID,Child,_),
    print_node(ID,0),
    print_tree(Child,1).
print_root(ID) :-
    is_root(ID),
    \+connection(ID,_,_),
    print_node(ID,0).

print_node(ID,Level):-
    print_text(ID,Level).

print_tree(ID,Level):-
    text(ID,_),
    connection(ID,Child,_),
    print_node(ID,Level),
    succ(Level,NextLevel),
    print_tree(Child,NextLevel).
print_tree(ID,Level):-
    text(ID,_),
    \+connection(ID,_,_),
    print_node(ID,Level).

main(ID) :-
    print_root(ID).
