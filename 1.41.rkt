#lang racket/base

(define (double f)
  (λ (x)
    (f (f x))))

(((double (double double)) add1) 5)
;= 21

;; potentially embarrassing confession: I incorrectly guessed "13" at first.

;; Let's try unfolding the computation to see why the answer is actually twenty-one.

;; WRONG FIRST STEP:
((((double double) (double double)) add1) 5)
;= 261

;; CORRECT FIRST STEP:
(((double double) ((double double) add1)) 5)
;= 21

(((double double) (double (double add1))) 5)
;= 21

((double (double (double (double add1)))) 5)
;= 21

;; (double (double (double (double add1))))
;; =
;; (double (double (double add2)))
;; =
;; (double (double add4))
;; =
;; (double add8)
;; =
;; add16
;;…
(+ 16 5)
;= 21
