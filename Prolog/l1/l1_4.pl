le(1,2).
le(2,3).
le(1,1).
le(2,2).
le(3,3).
le(1,3).
le(6,7).
le(7,8).
le(6,6).
le(7,7).
le(8,8).
le(6,8).
maksymalny(X) :- le(X,X) , \+ ( (le(X,Y) , X=\=Y )).
największy(X) :- le(X,X) , \+ ( le(Y,Y) , \+ le(Y,X) ).
minimalny(X) :- le(X,X) , \+ ( (le(Y,X) , X=\=Y )).
najmniejszy(X) :- le(X,X) , \+ ( le(Y,Y) , \+ le(X,Y) ).






















