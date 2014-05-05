#lang racket/base

(require (only-in racket/function const)
         "1.37.rkt")

(define (integral-quotient dividend divisor)
  (let ([r (remainder dividend divisor)])
    (/ (dividend . - . r)
       divisor)))

(define (approximate-e k)
  (+ 2 (cont-frac (const 1)
                  ;; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
                  (λ (i)
                    (if (= 2 (remainder i 3))
                        (* 2 (+ 1 (integral-quotient i 3)))
                        #i1))
                  k)))

(approximate-e 60)
;= 2.7182818284590455