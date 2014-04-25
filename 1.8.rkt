#lang racket/base

(require racket/local
         (only-in racket/math
                  sqr)
         (only-in "jtilles/prelude.rkt"
                  diff))

(define (cube-root x)
  (local [(define (good-enough? guess)
            (0.001 . < . (diff x guess)))
          
          ;;; In case you'll find it edifying, here's my moving toward the solution.
          #|

           (define (improve guess)
             (/ _
                3))

           (define (improve guess)
             (/ (+ _ _)
                3))

           |#

          (define (improve g)
            (/ (+ (x . / . (sqr g))
                  (* 2 g))
               3))
 
          (define (iterate guess)
            (if (good-enough? guess)
                guess
                (iterate (improve guess))))]
    (iterate 1.0)))
