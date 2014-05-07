(define (smooth f)
  (define dx 1e-5)
  (define (average x y z)
    (/ (+ x y z)
       3))
  (lambda (x)
    (average (f (+ x dx))
             (f x)
             (f (- x dx)))))

#|
(define (n-fold-smoothed-function f n)
  (define smooth-n-times (repeated smooth n))
  (smooth-n-times f))
|#
