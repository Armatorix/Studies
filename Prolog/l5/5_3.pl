get_order([H|L]) :-!,
	write(H),nl, write('command: '),
	get_char(C),
	(L=[L2],!;L2=L),
	step([H,L2],C).
get_order_q(L) :-!,
	get_char(C),
	step(L,C).
step(L,'\n') :-
	get_order_q(L).
step(_,'e') :- !.
step([],_):- !.
step(L,'i') :-!,
	L=[H|_], H =.. [_| Args] , Args = [H2|_], get_order([H2|L]).
step([_|L],'o') :-!,
	L=[L2],
	get_order(L2).
step([H|L2],'p') :-!,L2=[L3],L3=[L|_],
	L =.. [_ | Args] , nextto(X,H,Args) , get_order([X|L3]).
step([H|L2],'n') :-!,L2=[L3],L3=[L|_],
	L =.. [_ | Args] , nextto(H,X,Args) , get_order([X|L3]).

browse(Term) :-
	get_order([Term]),!.


