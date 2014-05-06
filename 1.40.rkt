#lang racket/base

(define (cubic a b c)
  (λ (x)
    (+ (* 1 (x . expt . 3))
       (* a (x . expt . 2))
       (* b (x . expt . 1))
       (* c (x . expt . 0)))))
