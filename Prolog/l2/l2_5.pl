fromoneton(N,L) :- findall(Numb,between(1, N, Numb),L).
doublelist(N,L3) :- fromoneton(N,L),append(L,L,L2), permutation(L2,L3).

memlen(_,_,2,Leng,Leng).
memlen(N,L, C,Len,Acc) :- L=[X|L1] ,
     (	 (N=X , ((C=0 , memlen(N,L1,1,Len,0)) ;
		(C=1 , memlen(N,L1,2,Len ,Acc )))) ;
        ((\+ N=X), ((C=0 , memlen(N,L1,0,Len,0)) ;
		   (C=1 , Acc2 is Acc+1 , memlen(N,L1,1,Len,Acc2)))) ).

twinlen(Numb,List) :-memlen(Numb,List,0,Leng,0) , (Leng mod 2) =:= 0.


nthhigher(Numb,[Numb|_]) :- !.
nthhigher(N,L) :-  L=[X1|L1] , X1<N , nthhigher(N,L1).

lista(N,L) :- findall(L2,doublelist(N,L2),LoL),
	sort(LoL,LoL2), member(L,LoL2), L=[W|_],
	W=1,
	\+ (between(1,N,X), \+ twinlen(X,L)),
	\+ (between(1,N,X2), \+ nthhigher(X2,L)).



/*
risehelper(N,[N|_],_) :- !.
risehelper(N,L,A) :- L=[X1|L1] , L1=[X2|_] , (X1=X2 ; X1+1=:=X2) , A1 is A+1 , risehelper(N,L1,A1).
halfrise(Numb,List) :- risehelper(Numb,List,0).
*/
