(define stack '()); first element = top

(define (push item) (set! stack (cons item stack)))

(define (pop)
	(let ((top (car stack)))
		(begin
			(set! stack (cdr stack))
			top)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define words '())

(define (define-words tokens word-data)
	(if (null? tokens) tokens
		(let ((current (car tokens)))
			(cond
				((equal? current ":")
					(define-words (cdr tokens) '(#t)))

				((equal? current ";")
					(begin
						(set! words (cons (cdr (reverse word-data)) words))
						(define-words (cdr tokens) '())))

				((not (null? word-data))
					(begin
						(set! tokens (cdr tokens))
						(define-words tokens (cons current word-data))))

				(else (define-words (cdr tokens) word-data))))))

(define (word-exists? word words)
	(cond
	  ((null? words) #f)
	  ((equal? word (caar words)) #t)
	  (else (word-exists? word (cdr words)))))

(define (remove-word-defs tokens searching)
	(cond
		((null? tokens) tokens)
		(searching
			(remove-word-defs (cdr tokens) (not (equal? (car tokens) ";"))))
		(else
			(if (equal? (car tokens) ":")
				(remove-word-defs (cdr tokens) #t)
				(cons (car tokens) (remove-word-defs (cdr tokens) #f))))))

; no null check needed because word-exists? is called beforehand
(define (call-word word words)
		(let ((current-word (car words)))
			(if (equal? (car current-word) word)
				(process-statement (cdr current-word))
				(call-word word (cdr words)))))