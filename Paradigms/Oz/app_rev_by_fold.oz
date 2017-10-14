local
   fun {Append L1 L2}
      case L1
      of nil then L2
      else {FoldR L1 fun {$ X Y} X|Y end  L2}
      end
   end
   fun {Reverse L}
      case L
      of nil then nil
      else {FoldL L fun {$ X Y} Y|X end nil}
      end
   end
   
   L1 = [1 2 3]
   L2 = [2 3]
in
	 {Browse {Append L2 L1}}
	 {Browse {Reverse L1}}
end
