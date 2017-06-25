
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

zwrotność :- \+(((le(X,_) ; le(_,X)), \+ le(X,X))). /*zwrotność*/
przechodniość :- \+ ((le(X,Y) , le(Y,Z), \+ le(X,Z))).
antysymetryczność :- \+ ((le(X,Y), le(Y,X) , \+le(X,X))).
częściowy_porządek :- zwrotność , przechodniość , antysymetryczność.
