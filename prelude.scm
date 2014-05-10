(define-library (utils josh prelude 0 0 1)

  (define half (lambda (n) (/ n 2)))
  
  (define (difference x y)
    (abs (- x y))))
