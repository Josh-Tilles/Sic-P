#lang racket/base

(require
 (only-in "jtilles/prelude.rkt"
          halve))

(define double (λ (x) (arithmetic-shift x 1))) ;; just bein' weird. don't mind me.

(define (mult a b)
  (cond [(zero? b) 0]
        [(= 1 b)   a]
        [(odd? b) (+ a 
                     (mult a (sub1 b)))]
        [(even? b) (mult (double a) 
                         (halve b))]
        [else
         (error "Something is gravely wrong— allegedly the number was neither even nor odd.")]))

