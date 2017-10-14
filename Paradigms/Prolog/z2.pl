jednokrotnie(X,L) :- select(X,L,L2), \+ member(X,L2),!.
dwukrotnie(X,L) :- select(X,L,L2), jednokrotnie(X,L2),!.
