					;---------------1--------------------
(define (mymap func list)
  (cons
   (func (car list))
   (if (null? (cdr list))
       ()
       (mymap func (cdr list)))))


					;---------------2--------------------
(define (dzialanie rownanie)
  (car (cdr rownanie)))
(define (arg1 rownanie)
  (car rownanie))
(define (arg2 rownanie)
  (third rownanie))
(define (pochodna rownanie argument)
  (if (list? rownanie)
      (cond ((eq? (dzialanie rownanie) '+)
	     (list (pochodna (arg1 rownanie) argument) '+ (pochodna (arg2 rownanie) argument)))
	    ((eq? (dzialanie rownanie) '-)
	     (list (pochodna (arg1 rownanie) argument) '- (pochodna (arg2 rownanie) argument)))
	    ((eq? (dzialanie rownanie) '/)
	     (list (list (list (pochodna (arg1 rownanie) argument) '* (arg2 rownanie)) '-
			 (list (arg1 rownanie) '* (pochodna (arg2 rownanie) argument)))
		   '/ (list (arg2 rownanie) '* (arg2 rownanie))))
	    ((eq? (dzialanie rownanie) '*)
	     (list (list (pochodna (arg1 rownanie) argument) '* (arg2 rownanie)) '+
		   (list (arg1 rownanie) '* (pochodna (arg2 rownanie) argument)))))
      (if (eq? rownanie argument) 1 0)))

					;---------------3--------------------
(define (member-if proc ls)
  (cond ((null? ls) #f)
	((proc (car ls)) #t)
	(else (member-if proc (cdr ls)))))

(define (decorator elem L2)
  (cond ((null? L2) ())
	((list? (car L2)) (cons (cons elem (car L2)) (decorator elem (cdr L2))))
	(else  (cons (list elem (car L2)) (decorator elem (cdr L2))))))

(define (splot2 L1 L2)
  (cond ((null? L1) ())
	((null? L2) L1)
	(else (append (decorator (car L1) L2) (splot2 (cdr L1) L2)))))

(define (smp_splot L)
  (if (null? L) () (cons (list (car L)) (smp_splot (cdr L)))))

(define (splot . args)
  (cond ((null? args) ())
	((null? (cdr args)) (smp_splot (car args)))
	((member-if null? args) ())
	(else (fold-right splot2 () args))))
