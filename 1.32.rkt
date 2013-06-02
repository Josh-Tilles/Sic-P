#lang racket

(define (accumulate combiner null-value term a next b)
  ;; `combiner` has two arguments that specifies how the current
  ;; term is to be combined with the accumulation of the preceding terms.
  ;; `null-value` specifies what base value to use when the terms run out.
  (if (< a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define sum
  (λ (nums)
    (accumulate + 0 nums)))
(define product
  (λ (nums)
    (accumulate * 1 nums)))

(define (iterative-accumulate combiner null-value term a next b)
  (define (iterate a result)
    (if (< a b)
        result
        (iterate (next a)
                 (combiner result (term a)))))
  (iterate a null-value))
