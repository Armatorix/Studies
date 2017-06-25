above(bike,pencil).
above(camera,butterfly).
left_of(pencil,sandglass).
left_of(sandglass, butterfly).
left_of(butterfly,fish).

right_of(Ob1, Ob2) :- left_of(Ob2,Ob1).
below(Ob1,Ob2) :- above(Ob2,Ob1).

left_of_r(Ob1, Ob2) :-left_of(Ob1,Ob2); (left_of(Ob1,Obz),left_of_r(Obz,Ob2)).
above_r(Ob1, Ob2) :-above(Ob1,Ob2); (above(Ob1,Obz),above_r(Obz,Ob2)).

higher(Ob2, Ob1) :- above_r(Ob1,Ob2);(left_of_r(Ob2,Obz),above_r(Ob1,Obz));(left_of_r(Obz,Ob2),above_r(Ob1,Obz)).
