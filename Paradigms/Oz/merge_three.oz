local
   fun {MergeTwo L1 L2}
      case L1#L2
      of nil#nil then
	 nil
      [] nil#L2 then
	 L2
      [] L1#nil then
	 L1
      else
	 local X1 T1 X2 T2 in
	    L1 = X1|T1
	    L2 = X2|T2
	    if X1=<X2 then
	       X1|{MergeTwo T1 L2}
	    else
	       X2|{MergeTwo L1 T2}
	    end 
	 end
      end
   end

   fun{Merge L1 L2 L3}
      {MergeTwo {MergeTwo L1 L2} L3}
   end
   L1 = [1 2 3]
   L2 = [4 4 4]
   L3 = [4 5 6]
in
   {Browse {Merge L1 L2 L3}}
end