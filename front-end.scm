(define (read-input char accum); accum = list of chars
	(if (eq? char #\newline) accum; reversed, but un-reversed in make-tokens
		(read-input (read-char) (cons char accum))))

(define (remove-spaces tokens)
	(cond
		((null? tokens) tokens)
		((null? (car tokens)) (remove-spaces (cdr tokens)))
		(else (cons (car tokens) (remove-spaces (cdr tokens))))))

(define (make-tokens chars tokens char-buffer)
	(if (null? chars) (cons char-buffer tokens)
		(let ((current-char (car chars)))
			(if (eq? current-char #\space)
				(make-tokens (cdr chars) (cons char-buffer tokens) '())
				(make-tokens (cdr chars) tokens (cons current-char char-buffer))))))

(define (tokenize chars) (remove-spaces (make-tokens chars '() '())))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (parse tokens)
	(if (null? tokens) tokens
	(let ((current-token (list->string (car tokens))))
		(let ((possible-num (string->number current-token)))
			(if possible-num
				(cons possible-num (parse (cdr tokens)))
				(cons current-token (parse (cdr tokens))))))))