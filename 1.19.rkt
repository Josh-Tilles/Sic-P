#lang racket

(require (only-in "jtilles/prelude.rkt"
                  half))

(define (fib n)
  (let iterate ([a 1] [b 0] [p 0] [q 1] [count n])
    (cond [(zero? count) b]
          [(even? count) (iterate a
                                  b 
                                  (+ (sqr p) (sqr q))
                                  (+ (* 2 q p) (sqr q))
                                  (half count))]
          [else 
           (iterate (+ (* b q) (* a q) (* a p))
                    (+ (* b p) (* a q))
                    p 
                    q
                    (sub1 count))])))

(require rackunit)
(check-eq? (fib 0) 0)
(check-eq? (fib 1) 1)
(check-eq? (fib 2) 1)
(check-eq? (fib 3) 2)
(check-eq? (fib 4) 3)
(check-eq? (fib 5) 5)
(check-eq? (fib 6) 8)
(check-eq? (fib 7) 13)
(check-eq? (fib 8) 21)
(check-eq? (fib 9) 34)