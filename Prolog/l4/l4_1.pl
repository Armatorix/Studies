give_marks(L,X) :-
	give_marks(L,[],X).
give_marks([],L,L).
give_marks([W|L1],L2,L3) :-
	L21 = [W|L2] ,( \+(L1 = []),
	((give_marks(L1,[+|L21],L3));
	 (give_marks(L1,[-|L21],L3));
	 (give_marks(L1,[*|L21],L3));
	 (give_marks(L1,[/|L21],L3)));
	( L1 = [] , give_marks(L1,L21,L3))).

reverseX(L,X) :-
	reverseX(L,[],X).
reverseX([],L,L).
reverseX([W|L1],L2,L3) :-
	reverseX(L1,[W|L2],L3).

my_sublist( List, X,Sublist ,Y ) :-
	append( [X, Sublist, Y], List ) , length(Sublist,LX) , LX >=3,
	Sublist = [Head|_] , number(Head), last(Sublist,X1) , number(X1).

bracketWay(L,LW) :-
	my_sublist(L,Start,Mid,End) , Midn = ['('|Mid] ,
	Endn = [')'|End] , append([Start,Midn,Endn],LW).
bracketRec(L,N,L2) :-
	N>1,N2 is N-1, bracketRec(L,N2,L2).
bracketRec(L,N,L2) :-
	N>0, bracketWay(L,L2).
not_div_zero(X) :- \+ (my_sublist(X,_,'/',L) , L=[H|_],(( number(H) , H=0 );(\+ number(H) , sublist(L,_,['('|Exp],[')'|_]),! , term_to_atom(Ex,Exp) , 0 is Ex) )).
wyrazenie([],_,_) :- !,false.
wyrazenie(L,Re,Ex) :-
	length(L,Len) ,	give_marks(L,L2) , reverseX(L2,LP),
	(L3 = LP ; (bracketRec(LP,Len,L3))),
	atomic_list_concat(L3,Exp),not_div_zero(Exp),term_to_atom(Ex,Exp), Re is Ex,!.
