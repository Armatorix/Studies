arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).
helper(X,X,_).
helper(X,Y,L) :- member(X,L) , member(Y,L).
helper(X,Y,L) :- member(Z,L) , arc(Z,W) ,\+ member(W,L) , helper(X,Y,[W|L]).
osiągalny(X,Y) :- helper(X,Y, [X]).	
