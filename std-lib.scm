(define (oper-proc operator) (lambda () (push (operator (pop) (pop)))))
(define (bool-proc operator) (lambda () (push (if (operator (pop) (pop)) -1 0))))

(define (print-pop)
	(let ((top (pop)))
		(begin
			(display top)
			(newline)
			top)))

; later on, maybe make the comparison between symbols? but only if it viable
(define builtins
	(list
		(list "+" (oper-proc +))
		(list "-" (oper-proc -))
		(list "*" (oper-proc *))
		(list "/" (oper-proc /))
		(list "=" (bool-proc =))
		(list ">" (bool-proc >))
		(list ">=" (bool-proc >=))
		(list "<" (bool-proc <))
		(list "<=" (bool-proc <=))
		(list "." print-pop))

)


(define (get-builtin name funcs)
	(cond
		((null? funcs) #f)
		; cadar = car of cdr of car
		((equal? (caar funcs) name) (cadar funcs))
		(else (get-builtin name (cdr funcs)))))

; implement:
; ., dup, drop, swap, over, rot, emit, cr
; also, catch the stack underflow exception:
; https://stackoverflow.com/questions/16493079/how-to-implement-a-try-catch-block-in-scheme
; or, maybe make a wrapper base func that all other funcs implement that check for an empty stack