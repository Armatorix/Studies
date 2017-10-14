arc(a,b).
arc(a,d).
arc(b,c).
arc(b,e).
arc(c,f).
arc(d,e).
arc(d,g).
arc(e,f).
arc(e,h).
arc(f,i).
arc(g,h).
arc(h,i).
helper(X,X,_).
helper(X,Y,L) :- member(X,L), member(Y,L).
helper(X,Y,L) :- member(Z,L), arc(Z,W), \+ member(W,L), helper(X,Y,[W|L]).
patch(X,Y) :- helper(X,Y,[X]).
