local
fun {Player Id RivalMoves}
   case RivalMoves
   of ping|L then {Delay 500}{Browse Id#pong} pong|{Player Id L}
   [] pong|L then {Delay 400}{Browse Id#ping} ping|{Player Id L}
   end
end

fun {Game Id1 Id2}
   local X1 X2 in
      thread X1=pong|{Player Id1 X2} end
      thread X2={Player Id2 X1} end
   end
end
in
   {Browse {Game fred john}}
end