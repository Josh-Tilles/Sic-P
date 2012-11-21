#lang racket

(require jtilles/prelude)

(define (cube-root x)
  (locals [(define (good-enough? guess)
             (0.001 . < . (diff x guess)))
           #| ; in the case that it's edifying, here's me moving toward the solution.
           (define (improve guess)
             (/ _
                3))

           (define (improve guess)
             (/ (+ _ _)
                3))
           |#

           (define (improve g)
             (/ (+ (x . / . (square g))
                   (* 2 g))
                3))

           (define (iterate guess)
             (if (good-enough? guess)
                 guess
                 (iterate (improve guess))))]
    (iterate 1.0))))
