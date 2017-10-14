local
   fun {NewQueueServer}
      Given GivePort={Port.new Given}
      Taken TakePort={Port.new Taken}
   in
      thread
	 for X in Given Y in Taken do
	    X=Y
	 end
      end
      queue(put:proc {$ X} {Port.send GivePort X} end
	    get:proc {$ X} {Port.send TakePort X} end)
   end
   
   proc {Talk Fun Port Interlokutor}
      {Delay 300}
      local Mess in
	 Mess = {Interlokutor.get $}
	 {Browse Mess}
	 {Port.put {Fun Mess}}
	 {Talk Fun Port Interlokutor}
      end	 
   end
   
   fun {Rozmowca Fun Interlokutor}
      local Port in
	 thread Port = {NewQueueServer} end
	 thread {Talk Fun Port Interlokutor} end
	 Port
      end
   end
   proc {Send Port Mess}
      {Port.put Mess}
   end
   R1 R2
in
   R1={Rozmowca fun {$ X} X+1 end R2}
   R2={Rozmowca fun {$ X} X-1 end R1}
   {Send R2 0}
end