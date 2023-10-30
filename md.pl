text('QdcyjbU3Vhvvey7G2O3E1','control flow is not data').
text('hrA0G0cV8-2jTwzZbZeXN','control flow is _interpretation_ of data - dynamic flow').
text('7BwhZNgIsA5BoJSMYfomd','a CPU is an interpreter').
text('1iqhffqqZDb4mCCOpXIet','a CPU interprets _opcodes_').
text('imhGfRoM95ixnSB-N0D5g','a CPU interprets _opcodes_ so quickly that we think of it as something other than interpretation').
text('kG4t71uepUS36ToC_iLvh','data is _static_ - and is not interpreted by the underlying system').
text('NszFdu5PKUwsja7G_czC2','static data is interpreted by the _program_, not the CPU').
connection('QdcyjbU3Vhvvey7G2O3E1','hrA0G0cV8-2jTwzZbZeXN','4TR-Saps8RXfUKXtkhJ7j').
connection('hrA0G0cV8-2jTwzZbZeXN','7BwhZNgIsA5BoJSMYfomd','4TR-Saps8RXfUKXtkhJ7j').
connection('7BwhZNgIsA5BoJSMYfomd','1iqhffqqZDb4mCCOpXIet','4TR-Saps8RXfUKXtkhJ7j').
connection('7BwhZNgIsA5BoJSMYfomd','imhGfRoM95ixnSB-N0D5g','4TR-Saps8RXfUKXtkhJ7j').
connection('kG4t71uepUS36ToC_iLvh','NszFdu5PKUwsja7G_czC2','4TR-Saps8RXfUKXtkhJ7j').
connection('QdcyjbU3Vhvvey7G2O3E1','kG4t71uepUS36ToC_iLvh','4TR-Saps8RXfUKXtkhJ7j').


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
