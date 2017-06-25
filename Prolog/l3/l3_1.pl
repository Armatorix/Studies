wariancjaH([],_,A,A).
wariancjaH(L,S,A,D) :- L = [W|L1] , A1 is A + (W-S)*(W-S) , wariancjaH(L1,S,A1,D).

średniaH([],A,A).
średniaH(L,A,S) :- L = [W|L1], A1 is A+W , średniaH(L1,A1,S).
średnia(L,S,Len) :- średniaH(L,0,S1), S is S1/Len.

wariancja(L,D) :- length(L,Len), średnia(L,S,Len) ,
	wariancjaH(L,S,0,D1) , D is D1/Len.








