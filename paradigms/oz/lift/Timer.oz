declare
fun {Timer}
	{NewPortObject2
	proc {$ Msg}
		case Msg 
		of starttimer(T Pid) then thread {Delay T} {Send Pid stoptimer} end
		end
	end}
end
