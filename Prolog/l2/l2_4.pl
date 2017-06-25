ma(asia   ,a).
ma(basia  ,b).
ma(kasia  ,k).
ma(danuta ,d).
daje(1 ,asia  ,a ,andrzej).
daje(2 ,basia ,b ,asia).
daje(3 ,kasia ,k ,asia).
daje(4 ,asia  ,k ,zosia).
ma(0,X,Y) :- ma(X,Y).
ma(T,X,Y) :- daje(T,_,Y,X).
/*ma(T,X,Y) :- ma(T1,X,Y), T1=<T , \+ (daje(T2,X,Y,_),T2=<T , T1=<T2).*/
