permute([], []).
permute([X|Rest], L) :-
    permute(Rest, L1),
    select(X, L, L1).
