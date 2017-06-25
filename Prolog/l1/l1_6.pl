isPrime(X) :-  X=2 ; (X>2, Z is X-1 , \+ (between(2,Z,Y), ((X mod Y )=:= 0))).
prime(LO,HI,N) :- between(LO,HI,N) , isPrime(N).
