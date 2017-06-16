local
   fun {GetMinimum X Y}
      case X#Y
      of X#nil then X
      [] nil#Y then Y
      else
	 if X>Y then Y else X end
      end
   end
   
   fun {IsPrimeHelper Check Nsqrt N}
      if Check > Nsqrt then
	 true
      elseif {Int.'mod' N Check} == 0 then
	 false
      else
	 {IsPrimeHelper Check+2 Nsqrt N}
      end
   end
   
   fun {IsPrime N}
      if N == 2 then
	 true
      elseif {Int.'mod' N 2} == 0 then
	 false
      else
	 {IsPrimeHelper 3 {FloatToInt {Sqrt {IntToFloat N}}} N}
      end
   end
   fun {KPrimeGenHelper Left Current}
      case Left of 0 then nil
      else
	 if {IsPrime Current} then
	    Current|{KPrimeGenHelper Left-1 Current+2}
	 else
	    {KPrimeGenHelper Left Current+2}
	 end
      end
   end
   
   fun {KPrimeGen K}
      case K of 0 then nil
      []   1 then [2]
      else 2|{KPrimeGenHelper K-1 3}
      end
   end
   
   fun {GenHelper LGenerated Prime Max LastRet}
      case LGenerated
      of nil then LastRet
      [] HLG|TLGenerated then
	 if HLG*Prime > Max then
	    {GenHelper TLGenerated Prime Max HLG*Prime}
	 else
	    LastRet
	 end
      end
   end
   fun {GenNext LPrimes LGenerated}
      local H in
	 H|_ = LGenerated
	 {FoldL LPrimes fun {$ X Y}
			   {GetMinimum X {GenHelper LGenerated Y H 1}} end nil}
      end
   end
   
   fun {HammingGen LPrimes LGenerated N}
      local NextGenerated in
	 NextGenerated = {GenNext LPrimes LGenerated}	    
	 if N == 0 then nil
	 elseif N == 1 then NextGenerated|nil
	 else NextGenerated|{HammingGen LPrimes  NextGenerated|LGenerated N-1}
	 end
      end
   end

   fun {HammingProblemSolver K N}
      if K == 0 then nil 
      elseif N == 0 then nil
      else
	 1|{HammingGen {KPrimeGen K} [1] N-1}
      end
   end
in
   {Browse {HammingProblemSolver 1 10}}
end
