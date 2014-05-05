#lang racket/base

(require 
 (only-in "jtilles/prelude.rkt"
          difference
          average)
 racket/local)

(define tolerance 1e-5)

(define (fixed-point--verbose func first-guess)
  (display "The verbose version of `fixed-point` has been entered.")
  (newline)
  (local [(define (close-enough? v1 v2)
            (tolerance . > . (difference v1 v2)))
          (define (try guess)
            (emit-log guess)
            (let ([next (func guess)])
              (if (close-enough? guess next)
                  next
                  (try next))))
          (define (emit-log x)
            (display "Attempting to use: ")
            (display x)
            (newline))]
    (try first-guess)))

(fixed-point--verbose (λ (x) (/ (log 1000)
                                (log x)))
                      7)

;;; I'm imitating *NIX command-line flags. Jus' becoz.
(define (fixed-point--verbose--with-average-damping func first-guess)
  (display "The version `fixed-point` with “average damping” has been entered.")
  (newline)
  (local [(define (close-enough? v1 v2)
            (tolerance . > . (difference v1 v2)))
          (define (try guess)
            (emit-log guess)
            (let ([next (func guess)])
              (if (close-enough? guess next)
                  next
                  (try (average next
                                guess)))))
          (define (emit-log x)
            (display "Attempting to use: ")
            (display x)
            (newline))]
    (try first-guess)))

(fixed-point--verbose--with-average-damping (λ (x) (/ (log 1000)
                                                      (log x)))
                                            7)
