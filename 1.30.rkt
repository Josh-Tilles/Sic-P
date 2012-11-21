#lang racket

#|
(define (sum term a next b)
  (define (iter a result)
    (if _
        _
        (iter _ (+ result _ ))))
  (iter _ _))

(define (sum term a next b)
  (define (iter a result)
    (if _
        _
        (iter (next a) (+ result (term a)))))
  (iter _ _))
|#

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))
