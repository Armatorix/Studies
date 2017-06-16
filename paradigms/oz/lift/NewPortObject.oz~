declare
proc {NewPortObject Init Fun ?P}
   proc {MsgLoop S1 State}
      case S1 
      of Msg|S2 then {MsgLoop S2 {Fun Msg State}}
      [] nil then skip 
      end
   end
   Sin
in
   thread {MsgLoop Sin Init} end
   {NewPort Sin P}
end
