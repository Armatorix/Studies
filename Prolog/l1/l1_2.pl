on(1,2).
on(2,3).
on(3,4).
on(4,5).
on(5,6).
on(10,11).
above(X,Y) :- on(X,Y) ; (on(X,Z),above(Z,Y)).

