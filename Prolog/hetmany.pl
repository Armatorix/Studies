hetmany(N,X) :- findall(I,between(1,N,I),L), permutation(L,X) , dobra(X).
dobra(X) :- \+ zla(X).
zla(X) :- append(_,[Wi|L1],X), append(L2,[Wj|_],L1), length(L2,K), abs(Wi-Wj) =:= K+1.
