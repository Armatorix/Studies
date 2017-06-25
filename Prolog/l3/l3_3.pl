/*CALL L,N,0,X*/
how_much_higher([],_,X,X).
how_much_higher([W|L],N,Acc,X) :-
	(W>N, Acc1 is Acc + 1, how_much_higher(L,N,Acc1,X));
	(W=<N , how_much_higher(L,N,Acc,X)).

/*CALL L,[],0,X*/
sum_of_higher([],_,X,X).
sum_of_higher([W|L],L2,Acc,X) :- how_much_higher(L2,W,0,Acp), Acc1 is Acc+Acp, sum_of_higher(L,[W|L2],Acc1,X).
/*1 if odd , 0 if even*/

sign_of_list(L,X) :- sum_of_higher(L,[],0,Ac), X is Ac mod 2.

even_permutation(L1,L2) :- findall(X1,permutation(L1,X1), LP), sort(LP,LPS), member(L2,LPS), sign_of_list(L1,S1), sign_of_list(L2,S2) , S1 = S2.

odd_permutation(L1,L2) :- findall(X1,permutation(L1,X1), LP), sort(LP,LPS), member(L2,LPS), sign_of_list(L1,S1), sign_of_list(L2,S2) , S1 =\= S2.

