(define (compose g f)
  (lambda (x)
    (g (f x))))
