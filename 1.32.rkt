#lang racket/base
(require
  (only-in racket/function
           identity))

;;; Where's the bug?
#|

(define (accumulate combiner null-value term a next b)
  ;; `combiner` has two arguments that specifies how the current
  ;; term is to be combined with the accumulation of the preceding terms.
  ;; `null-value` specifies what base value to use when the terms run out.
  (if (< a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (sum lower-bound upper-bound)
  (accumulate + 0 identity lower-bound add1 upper-bound))

(define (product lb ub)
  (accumulate * 1 identity lb add1 ub))

(define (iterative-accumulate combiner null-value term a next b)
  (define (iterate a result)
    (if (< a b)
        result
        (iterate (next a)
                 (combiner result (term a)))))
  (iterate a null-value))

|#

;;; real answer:
(define (accumulate combiner null-value term a next b)
  ;; `combiner` has two arguments that specifies how the current
  ;; term is to be combined with the accumulation of the preceding terms.
  ;; `null-value` specifies what base value to use when the terms run out.
  (if (a . > . b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (sum lower-bound upper-bound)
  (accumulate + 0 identity lower-bound add1 upper-bound))

(define (product lb ub)
  (accumulate * 1 identity lb add1 ub))

;; which do you prefer? the "verbose" parameter names? Or the abbreviated parameter names?

(define (iterative-accumulate combiner null-value term a next b)
  (define (iterate a result)
    (if (> a b)
        result
        (iterate (next a)
                 (combiner result (term a)))))
  (iterate a null-value))
