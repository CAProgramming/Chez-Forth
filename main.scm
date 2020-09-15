(load "front-end.scm")
(load "back-end.scm")
(load "std-lib.scm")

(define (handle-token token)
	(let ((possible-builtin (get-builtin token builtins)))
		(cond
			(possible-builtin (possible-builtin))
			((number? token) (push token))
			((word-exists? token words) (call-word token words))
			(else
				(display (format "Error: invalid token ~s\n" token))))))

(define (process-statement tokens)
	(cond
		((null? tokens) tokens)
		((null? (cdr tokens))
			(handle-token (car tokens)))
		(else (begin
				; (display "General processing\n")
				(handle-token (car tokens))
				; (display "About to define words\n")
				(process-statement (cdr tokens))))))

(define (repl)
	(begin
		; (display (format "Words: ~s\n" words))
		; (display (format "Stack: ~s\n" stack))
		(display "> ")
		(let ((expression (parse (tokenize (read-input (read-char) '())))))
			(if (not (null? expression))
			  (begin
				(define-words expression '())
				; (display (format "Just defined words. Here are tokens now: ~s\n" expression))
				(process-statement (remove-word-defs expression #f))
				)))
		(repl)))

(repl)

; and also catching the "pair" error in some way
