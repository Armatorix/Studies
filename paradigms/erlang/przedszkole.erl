-module(przedszkole).
-import(lists,[delete/2,member/2]).
-export([przedszkolanka/1,rodzic/0,start/0]).

przedszkolanka(N) ->
  przedszkolanka1(N,[]).
przedszkolanka1(N,L) ->
  receive
    {getSomeRest} ->
      done;                
    {Kto,pozostaw,Imie} ->
      case N =:= 0 of
        true -> Kto ! {error, Imie},
                przedszkolanka1(N,L);
        false -> Kto ! {ok, Imie},
                 przedszkolanka1(N-1, [{Kto,Imie}|L])
      end;
    {Kto,odbierz,Imie} ->
      case member({Kto,Imie}, L) of
        true -> Kto ! {ok, Imie}, 
                przedszkolanka1(N+1, delete({Kto,Imie},L));
        false -> Kto ! {error, Imie},
                 przedszkolanka1(N,L)
      end
  end.
rodzic() ->
  receive
    {getSomeRest} ->
      done;
    {ok,Imie} -> 
      io:format("Parent ~p get message ok:~p~n",[self(),Imie]), rodzic();
    {error,Imie} ->
      io:format("Parent ~p get error message:~p~n",[self(),Imie]), rodzic()
  end.

start() ->
  P = spawn(przedszkole, przedszkolanka, [3]),
  R1 = spawn(przedszkole, rodzic,[]),
  R2 = spawn(przedszkole, rodzic,[]),
  R3 = spawn(przedszkole, rodzic,[]),
  P ! {R1, odbierz, krystyna},
  P ! {R1, pozostaw, krystyna},
  P ! {R2, pozostaw, krystyna},
  P ! {R3, pozostaw, krystyna},
  P ! {R3, pozostaw, kazik},
  P ! {R3, odbierz, kazik},
  P ! {R3, odbierz, krystyna},
  P ! {R3, odbierz, krystyna},
  P ! {R2, odbierz, krystyna},
  P ! {R1, odbierz, krystyna}.
