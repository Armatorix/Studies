-module(test).
-export([pythag/1, left_rotation/1]).

pythag(N) ->
  [{A,B,C} ||
   A <- lists:seq(1, (N div 3)),
   B <- lists:seq(A, (N div 2) -1),
   C <- [N-A-B],
   C*C == A*A + B*B].
left_rotation({node, _, _, _, nil}) ->
  error;
left_rotation({node, Key, Val, Left, {node, KeyR, ValR, LeftR, RightR}}) ->
  {node, KeyR, ValR,{node, Key, Val, Left, LeftR}, RightR}.
