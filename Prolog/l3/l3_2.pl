max_sum([],_,Max,Max).
max_sum([W|L],A,Mcc,Max) :- A1 is A+W,
	(   (A1<0, max_sum(L,0,Mcc,Max));(A1>=0, ((A1>=Mcc, max_sum(L,A1,A1,Max));(A1<Mcc, max_sum(L,A1,Mcc,Max))) )).
max_sum([],0).
max_sum(L,LS) :- max_sum(L,0,0,LS).
