#lang racket

(define (cont-frac n d k)
  (let iter ([i k] [res 0])
    (if (zero? i)
        res
        (iter (sub1 i)
              (/ (n i)
                 (+ res (d i)))))))


(define (integral-quotient dividend divisor)
  (let ([r (remainder dividend divisor)])
    (/ (dividend . - . r)
       divisor)))

(define (approximate-e k)
  (+ 2 (cont-frac (const 1)
                  ;; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
                  (λ (i)
                    (if (= 1 (remainder i 3))
                             (* 2 (+ 1 (integral-quotient i 3)))
                             #i1))
                  k)))

(approximate-e 60)
