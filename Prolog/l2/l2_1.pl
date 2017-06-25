%lista główna, lista skrócona
bez_ostatniego([_], []).
bez_ostatniego([X|Ogon1], [X|Ogon2]) :- bez_ostatniego(Ogon1, Ogon2).

bez_pierwszego(L1,L2) :- L1 = [_X|L2].
%L-lista, X-środkowy element
środkowy(L,X) :- L=[X].
środkowy(L,X) :- bez_ostatniego(L,L2), bez_pierwszego(L2,L3), środkowy(L3,X).
