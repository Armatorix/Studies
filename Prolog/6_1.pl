/*5.1*/
key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).
not_low(L) :- \+ ( member(Y,L) , char_type(Y,lower)).
id(ID) :- string_chars(ID,L) , not_low(L).

sep(SEPARATOR) :- member(SEPARATOR,[ ;, +, -, *, /,'(', ')', <, >, =<, >=, :=, =,/=]),!.
int(LICZBA_NATURALNA) :- integer(LICZBA_NATURALNA), LICZBA_NATURALNA >=0.

bialy(' ').
bialy('\t').
bialy('\n').
cudzy(';').
czytaj(Stream,X) :- get_char(Stream,C), czytaj_dalej(Stream,C,X),!.
czytaj_dalej(_,end_of_file,[]) :-
	!.
czytaj_dalej(Stream,C1,X) :-
	 bialy(C1),!,
	get_char(Stream,C2), czytaj_dalej(Stream,C2,X).
czytaj_dalej(Stream,C1,[H|T]) :-
	(  (C1=';',
	   H=';',
	   get_char(Stream,C2));
	   ( \+ C1=';' ,
	   czytaj_slowo(Stream,C1,C2, '',H))),
	 czytaj_dalej(Stream,C2,T).
czytaj_slowo(_,end_of_file,end_of_file,N,N) :-
	!.
czytaj_slowo(_,C,C,N,N) :-
	bialy(C),!.
czytaj_slowo(_,C,C,N,N) :-
	cudzy(C),!.
czytaj_slowo(Stream,C1,C3,N1,N) :-
	atom_concat(N1,C1,N2),
	get_char(Stream,C2),
	czytaj_slowo(Stream,C2,C3,N2,N).
imper([],[]).
imper([H1|L1],[H2|L2]) :-
	(   (key(H1),H2=key(H1),!);
	(sep(H1),H2=sep(H1),!);
	(int(H1),H2=int(H1),!);
	(id(H1), H2=id(H1),!)),
	imper(L1,L2).
scaner(Strumien, Tokeny) :-
	czytaj(Strumien,X),
	imper(X,Tokeny).

/*6.1*/
program("") -->[] .
program(PP) -->
	instrukcja(I) ,
	[sep(;)],
	program(P),
	{atomic_concat("[ ",I,X2),
	 atomic_concat(X2,",",X3),
	 atomic_concat(X3,P,X4),
	 atomic_concat(X4," ]",PP)}.
instrukcja(X2) -->
	[key(read)] ,
	[id(X)],
	{atomic_concat("read(",X,X1),
	 atomic_concat(X1,")",X2)}.
instrukcja(X2) -->
	[key(write)] ,
	wyrazenie(X),
	{atomic_concat("write(",X,X1),
	 atomic_concat(X1,")",X2)}.
instrukcja(X5) -->
	[id(X)] ,
	wyrazenie(W),
	{atomic_concat("assign(",X,X2),
	 atomic_concat(X2,",",X3),
	 atomic_concat(X3,W,X4),
	 atomic_concat(X4,")",X5)}.
instrukcja(X4) -->
	[key(if)] ,
	warunek(X),
	[key(then)] ,
	program(P),
	[key(fi)],
	{atomic_concat("if(",X,X1),
	 atomic_concat(X1,",",X2),
	 atomic_concat(X2,P,X3),
	 atomic_concat(X3,")",X4)}.
instrukcja(X6) -->
	[key(if)] , warunek(X),
	[key(then)] , program(P1),
	[key(else)],program(P2),
	[key(fi)],
	{atomic_concat("if(",X,X1),
	 atomic_concat(X1,",",X2),
	 atomic_concat(X2,P1,X3),
	 atomic_concat(X3,",",X4),
	 atomic_concat(X4,P2,X5),
	 atomic_concat(X5,")",X6)}.

instrukcja(X4) -->
	[key(while)], warunek(X),
	[key(do)], program(P),
	[key(od)],
	{atomic_concat("while(",X,X1),
	 atomic_concat(X1,",",X2),
	 atomic_concat(X2,P,X3),
	 atomic_concat(X3,")",X4)}.

wyrazenie(XX) -->
	[id(X)],
	{atomic_concat("id(",X,X1) ,
	 atomic_concat(X1,")",XX)}.
wyrazenie(XX) -->
	[int(X)],
	{atomic_concat("int(",X,X1) ,
	 atomic_concat(X1,")",XX)}.

wyrazenie(WW) -->
	wyrazenie(W1) ,
	[sep(+)],
	wyrazenie(W2),
	{atomic_concat(W1,"+",WN) ,
	 atomic_concat(WN,W2,WW)}.
wyrazenie(WW) -->
	wyrazenie(W1) ,
	[sep(-)],
	wyrazenie(W2),
	{atomic_concat(W1,"-",WN) ,
	 atomic_concat(WN,W2,WW)}.
wyrazenie(WW) -->
	wyrazenie(W1) ,
	[sep(*)],
	wyrazenie(W2),
	{atomic_concat(W1,"*",WN) ,
	 atomic_concat(WN,W2,WW)}.
wyrazenie(WW) -->
	wyrazenie(W1) ,
	[sep(/)],
	wyrazenie(W2),
	{atomic_concat(W1,"/",WN) ,
	 atomic_concat(WN,W2,WW)}.
wyrazenie(WW) -->
	wyrazenie(W1) ,
	[key(mod)],
	wyrazenie(W2),
	{atomic_concat(W1,"mod",WN) ,
	 atomic_concat(WN,W2,WW)}.

warunek(WW) -->
	wyrazenie(W1) ,
	[sep(:=)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,":=",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	wyrazenie(W1) ,
	[sep(=\=)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,"=\\=",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	wyrazenie(W1) ,
	[sep(<)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,"<",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	wyrazenie(W1) ,
	[sep(>)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,">",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	wyrazenie(W1) ,
	[sep(=<)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,"=<",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	wyrazenie(W1) ,
	[sep(>=)] ,
	wyrazenie(W2) ,
	{atomic_concat(W1,">=",WW1),
	 atomic_concat(WW1,W2,WW)}.

warunek(WW) -->
	warunek(W1),
	[sep(;)] ,
	warunek(W2),
	{atomic_concat(W1,";",WW1),
	 atomic_concat(WW1,W2,WW)}.
warunek(WW) -->
	warunek(W1),
	[sep(,)] ,
	warunek(W2),
	{atomic_concat(W1,",",WW1),
	 atomic_concat(WW1,W2,WW)}.
