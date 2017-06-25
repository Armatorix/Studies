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
