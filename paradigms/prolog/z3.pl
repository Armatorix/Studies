sito(N,Output) :-
  sieve(L,Output),
  numlist(2,N,L).

sieve(Input, Output) :-
        freeze(Input,
        (Input = [Hin|Tin] ->
          Output = [Hin|Tout],
          filter(Hin,Tin,Fout),
          sieve(Fout,Tout);
        Output = [])).
filter(N, Input, Output) :-
  freeze(Input,
  ( Input = [X|T] ->
    ( X mod N =:= 0 ->
      filter(N, T, Output) ;
      Output = [X|Tout],
      filter(N, T, Tout)) ;
      Output = [])).
