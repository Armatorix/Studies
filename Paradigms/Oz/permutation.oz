local
   fun {NoList Nos Noe}
      if Nos == Noe then
	 nil
      else
	 Noe-1|{NoList Nos Noe-1}
      end
   end
   
   fun {Decorate L X}
      {Map L fun {$ Y} X|Y end}
   end
   
   fun {Select L No}
      local Ll H Lr in
	 {List.takeDrop L No Ll H|Lr}
	 {Append Ll Lr}
      end
   end
   
   fun {PermHelper L N}
      local Ret Lh Lt Nh Nt in
	 N = Nh|Nt	 
	 if Nt == nil then
	    Ret = L|nil
	 else
	    L = Lh|Lt
	    Ret = {FoldR N fun {$ X Y}
			      {Append {Decorate {PermHelper {Select L X} Nt} {Nth L X+1}} Y}
			   end nil}
	 end
	 Ret
      end
   end
   
   fun {Permutation L}
      {PermHelper L {NoList 0 {Length L}}}
   end
   T = [1 2 3 4]
in
   {Browse {Permutation T}}
end