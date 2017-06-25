arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).

node(X):- arc(X,_) ; arc(_,X).
helper(_,_,L,L) :- \+ (arc(W,Z) , member(W,L) , \+ member(Z,L)).
helper(X,Y,L,L1) :- arc(W,Z) , member(W,L) , \+ member(Z,L), helper(X,Y,[Z|L],L1).
helpX(X,Y,L) :- helper(X,Y,[X],L),!.
osiągalny(X,Y) :- findall(X,node(X),LX) ,  sort(LX, LXW) , member(X,LXW), helpX(X,Y,L),
	 member(Y,L).
