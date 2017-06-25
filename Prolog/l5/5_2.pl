dobra(X) :-
	\+ zla(X).

zla(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K+1.

hetmany(N, P) :-
	numlist(1, N, L),
	permutation(L, P),
	dobra(P).

remakeList([],[],_).
remakeList([H1|L1],[H2|L2],Len) :-
	remakeList(L1,L2,Len),
	H2 is (Len-H1).
indexOf([X|_], X, 0).
indexOf([_|T], X, Index) :-
  indexOf(T, X, Index1),
  Index is Index1+1.
listOfIndexes(L,El,LW) :-
	findall(X,indexOf(L,El,X),LW).

line_row(0).
line_row(N) :- write('-----+'),N1 is N-1,line_row(N1).
empty_black_cell() :-
	write(':::::|').
filled_black_cell() :-
	write(':###:|').
empty_white_cell() :-
	write('     |').
filled_white_cell() :-
	write(' ### |').
normal_row(_,N,N,_) :- !.
normal_row(L,Len,Cell,Row) :-
	LMOD is (Len-1) mod 2, CellMOD is (Cell+Row) mod 2,
	(   (LMOD = CellMOD,!, ((member(Cell,L),!,filled_black_cell());(empty_black_cell())));
	    ((member(Cell,L),!,filled_white_cell());(empty_white_cell()) )
	),
	Cell1 is Cell +1,
	normal_row(L,Len,Cell1,Row).
print_rows(_,N,N).
print_rows(L,Len,Row) :-
	nl,write('+'),line_row(Len),nl,
	listOfIndexes(L,Row,LW),
	write('|'), normal_row(LW,Len,0,Row),nl,
	write('|'),normal_row(LW,Len,0,Row),Row2 is Row+1,
	print_rows(L,Len,Row2).

board([]) :-
	write('Podaj jakas niepusta tablice ?'),!.
board(L) :-
	member(X,L) , length(L,Len), X>Len , write('Zle dane!'),!.
board(L) :-
	length(L,Len) , remakeList(L,L2,Len),print_rows(L2,Len,0), nl,write('+'),line_row(Len),!.
