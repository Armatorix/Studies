merge(IN1, IN2, OUT2) :-
	(   IN1=[] -> (IN2 = [H2|R2], OUT2 = [H2|OUT], merge([],R2,[OUT]))
	;   (IN2=[] -> (IN1 = [H1|R1], OUT2 = [H1|OUT],merge([],R1,[OUT])))
	;   (IN1 = [H1|R1], IN2 = [H2|R2] ,
	    ( H1<H2 -> OUT2 = [H1|OUT], merge(R1,IN2,[OUT]) ; OUT2 = [H2|OUT],merge(IN1,R2,[OUT])))
	;   OUT2 = []).
