local
   fun {Insert Key Value Tree}
      case Tree
      of leaf then tree(Key Value leaf leaf)
      [] tree(K V T1 T2) then
	 if Key == K then
	    tree(Key Value T1 T2)
	 elseif Key < K then
	    tree(K V {Insert Key Value T1} T2)
	 else
	    tree(K V T1 {Insert Key Value T2})
	 end
      end
   end
   fun {FindAll Value Tree}
      case Tree
      of leaf then nil
      [] tree(K V T1 T2) then
	 local Kl Kr X in
	    Kl = {FindAll Value T1}
	    Kr = {FindAll Value T2}
	    if Value == V then
	       X = {Append Kl K|Kr}
	    else
	       X = {Append Kl Kr}
	    end
	    X
	 end
      end
   end
   T
in
   {Browse '---here start---'}
   T = {Insert 6 6 {Insert 10 4 {Insert 7 5 {Insert 3 6 {Insert 1 4 {Insert 2 6 {Insert 5 4 leaf}}}}}}}
   {Browse {FindAll 4 T}}
end
