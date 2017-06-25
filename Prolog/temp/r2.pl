rel(o1,p1,s2).
rel(o2,p2,s4).
rel(o3,p2,s1).
rel(o7,p5,s5).
rel(o9,p1,s4).
rel(o2,p6,s7).
rel(o3,p3,s2).
rel(o6,p6,s3).
rel(o5,p7,s2).
rel(o4,p2,s1).
rel(o3,p3,s1).
relFinder(X1,X2) :- 
        (rel(X1,P,X2) ; rel(X2,P,X1)), 
        write(X1),write(" "),
        write(P) ,write(" "),
        write(X2),!.

relFinder(X1,X2) :- 
	(rel(X1,P,XT) ; rel(XT,P,X1)),
        write(X1),write(" "),
        write(P) ,write(" "),
        relFinder(XT,X2).
