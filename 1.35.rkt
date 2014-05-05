#lang racket/base

(require (only-in "jtilles/prelude.rkt"
                  difference)
         racket/local)

(define tolerance 1e-5)

(define (fixed-point func first-guess)
  (local [(define (close-enough? v1 v2)
            (tolerance . > . (difference v1 v2)))
          (define (try guess)
            (let ([next (func guess)])
              (if (close-enough? guess next)
                  next
                  (try next))))] ;; Note the tail recursion
    (try first-guess)))


(require rackunit)

(let ([golden-ratio (/ (+ 1 (sqrt 5))
                       2)])
  (check-= golden-ratio
           (fixed-point (λ (x) (+ 1 (/ x)))
                        5) ;; I don't think the number that you pick actually matters...
           tolerance))