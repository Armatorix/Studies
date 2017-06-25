ilość(L, X, C) :- ilość(L,X,0,C).
ilość([],_X,A,A).
ilość(L, X, A, C) :- L=[Y|L2], ((X=Y , A2 is A + 1, ilość(L2,X,A2,C))
			       ;((\+ X=Y) , ilość(L2,X,A,C))).
jednokrotnie(X,L) :- member(X,L),ilość(L,X,1).
dwukrotnie(X,L) :- msort(L,LS), nextto(A,X,LS), ilość(LS,X,2) , A=X.
