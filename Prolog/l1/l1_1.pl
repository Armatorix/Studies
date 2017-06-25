kobieta(k1).
kobieta(k2).
kobieta(b). /*babcia*/
kobieta(c). /*ciocia*/
mężczyzna(dz). /*dziadek*/
mężczyzna(m1).
mężczyzna(m2).
mężczyzna(d).
rodzic(k1,d).
rodzic(m1,d).
rodzic(b,k1).
rodzic(dz,k1).
rodzic(b,c).
rodzic(dz,c).
ojciec(m1,d).
ojciec(dz,k1).
ojciec(dz,c).
/*
           b d
	c       k1 m1
		  d
*/
jest_matką(X) :- kobieta(X), rodzic(X,_).
jest_ojcem(X) :- mężczyzna(X), rodzic(X,_).
jest_synem(X) :- mężczyzna(X), rodzic(_,X).
siostra(X,Y) :- kobieta(X), rodzic(Z,X), rodzic(Z,Y), X \= Y.
dziadek(X,Y) :- rodzic(Z,Y), ojciec(X,Z).
rodzenstwo(X,Y) :-rodzic(Z,X), rodzic(Z,Y), X \= Y.
