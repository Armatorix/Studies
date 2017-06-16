local
   fun {Analyzer L Vin Vout}
      case L
      of nil then
	 Vout = Vin
	 nil
      [] H|T then
	 if H>Vin then
	    H|{Analyzer T Vin Vout}
	 else
	    Vin|{Analyzer T H Vout}
	 end
      end
   end
   
   proc {NSort IN OUT}
      {Browse 'new thread'#IN#OUT}
      case IN
      of nil then
	 OUT = nil
      [] H|nil then
	 OUT = H|nil
      [] H|T then
	 local IN2 OUT2 Vout in
	    thread {NSort IN2 OUT2} end
	    thread IN2 = {Analyzer T H Vout} end
	    OUT = Vout|OUT2
	 end
      end
   end

   fun {Slowmotion IN}
      {Delay 500}
      case IN
      of nil then nil
      [] H|T then H|{Slowmotion T}
      end
   end
   
   O
   IN = [9 2 4 6 21 8 5 21 47 7 3]
   IN2
in
   thread IN2 = {Slowmotion IN} end
   {NSort IN2 O}
   {Browse IN#sorted#O}
end
