road(1,a,b).
road(2,a,d).
road(3,b,c).
road(4,c,d).
road(5,b,e).
road(6,c,f).
road(7,d,f).
road(8,e,f).

route(A,A,R,R).
route(A,B,R,R2) :- road(Rx,A,C), \+ member(Rx,R) , route(C,B,[Rx|R],R2).
route(A,B,R) :- route(A,B,[],Rx), reverse(R,Rx).
