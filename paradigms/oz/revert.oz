local
   fun {RevH L L2}
      case L
      of nil then L2
      [] X|T then {RevH T X|L2}
      end
   end   
   fun {Rev L}
      {RevH L nil}
   end
   Li = [a l b x]
   Lo
in
   Lo = {Rev Li}
   {Browse Lo}
end
