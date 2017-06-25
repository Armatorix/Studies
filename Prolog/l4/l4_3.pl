printX(X,Y) :-
	member(X,[2,3,9,10,16,17,23,24]),
	((Y=1 ,print('---*'));(Y=0 , print('   *'))) ;
	member(X,[1,8,15,22]),
	((Y=1 ,print('\n*---*'));(Y=0 , print('\n*   *'))) ;
	member(X,[4,11,18]),
	((Y=1 ,print('\n|   '));(Y=0 , print('\n    '))) ;
	member(X,[5,6,7,12,13,14,19,20,21]),
	((Y=1 ,print('|   '));(Y=0 , print('    '))).

printRec(28,_) :-
	print('\n').
printRec(X,L) :-
	((member(X,L),printX(X,1));(\+member(X,L),printX(X,0))) ,
	X1 is X+1, printRec(X1,L).
printRec(L) :-
	printRec(1,L), nl.

/*
select_few(L,0,L,_).
select_few(L,N,Ln,B) :- member(X,L), X>B, select(X,L,L2) , N2 is N-1, select_few(L2,N2,Ln,X).
select_few(L,N,Ln) :- select_few(L,N,Ln,0).
*/

sublist([],_).
sublist([X|X1],[X|X2]) :-
	sublist(X1,X2).
sublist(X1,[_|X2]) :-
	sublist(X1,X2).

select_few(L,N,Ln) :- sublist(Ln,L), length(Ln,X), X is 24-N.

duze(L,X) :-
	(sublist([1,2,3,4,7,11,14,18,21,22,23,24],L) , X=1);
	(\+sublist([1,2,3,4,7,11,14,18,21,22,23,24],L) , X=0).
srednie(L,X) :- srednie(L,0,0,X),!.
srednie(_,C,X,X) :-
	C=9.
srednie(L,C,Ac,X) :-
	member(Cn,[1,2,8,9]) ,
	Cn>C, Cn1 is Cn+1, Cn2 is Cn1+2, Cn3 is Cn2+2 ,
	Cn4 is Cn3+5, Cn5 is Cn4+2 , Cn6 is Cn5+2 , Cn7 is Cn6+1 ,
	((sublist([Cn,Cn1,Cn2,Cn3,Cn4,Cn5,Cn6,Cn7],L), Ac2 is Ac+1 , srednie(L,Cn,Ac2,X));
	(\+sublist([Cn,Cn1,Cn2,Cn3,Cn4,Cn5,Cn6,Cn7],L), srednie(L,Cn,Ac,X))).
male(L,X) :- male(L,0,0,X),!.
male(_,C,X,X) :-
	C=17.
male(L,C,Ac,X) :-
	member(Cn,[1,2,3,8,9,10,15,16,17]) ,
	Cn>C, Cn1 is Cn+3, Cn2 is Cn1+1, Cn3 is Cn2+3,
	((sublist([Cn,Cn1,Cn2,Cn3],L), Ac2 is Ac+1 , male(L,Cn,Ac2,X));
	(\+sublist([Cn,Cn1,Cn2,Cn3],L), male(L,Cn,Ac,X))).



fromoneton(N,L) :- findall(Numb,between(1, N, Numb),L).

zapalki(Take, KWADRATY) :-
	KWADRATY = (duze(X1),srednie(X2),male(X3)), fromoneton(24,L),!,
	select_few(L,Take,L2) ,
	duze(L2,X1),
	srednie(L2,X2)  ,
	male(L2,X3) ,
	printRec(L2).
