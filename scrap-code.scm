(define (in elem lst)
	(cond 
		((null? lst) #f)
		((eq? (car lst) elem) #t)
		(else (in elem (cdr lst)))))