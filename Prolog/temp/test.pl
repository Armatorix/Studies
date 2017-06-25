myFiltr([],_,[]).
myFiltr([H|T],F,R) :- myFiltr(T,F,R2),
                    (H = (_,_,F,_) -> 
                     R = [H|R2]
                     ;R=R2).

myMax([H|T],X1) :- T=[] -> 
                        X1 = H
                        ;   (myMax(T,X2), 
                            H = (V1,_,_,_),
                            X2 =(V2,_,_,_),
                            V2>V1 ->
                                X1 = X2
                                ;X1= H).
findMaxWithFiltr(List,Filtr,Result) :- myFiltr(List,Filtr,R2), myMax(R2,Result).
