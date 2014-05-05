#lang racket/base

(require racket/local
         (only-in racket/math sqr)
         "1.37.rkt")

(define (tan-cf x k)
  (cont-frac (λ (i)
               (if (zero? i) ; vs `(= i 1)`? Stylistically, is there a reason to prefer one over the other?
                   x
                   (- (sqr x))))
             (λ (i)
               (sub1 (* 2 (add1 i)))) ; odd numbers
             k))

(tan 1.5)
;= 14.10141994717172
(tan-cf 1.5 30)
;= 14.101419947171719
