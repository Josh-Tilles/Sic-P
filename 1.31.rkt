#lang racket

(define additive-identity 0)
(define multiplicative-identity 1)

;; This one is iterative.
(define (product term init next limit)
  (let iter ([n init]
             [result multiplicative-identity])
    (if (n . > . limit)
        result
        (iter (next n)
              (* result (term n))))))

(define (factorial n)
  (product identity 1 add1 n))

(factorial 0)
(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)

;;; Exercise 1.32B
(define (recursive-product term a next b)
  (if (< b a)
      1 ;multiplicative-identity
      (* (term a)
         (recursive-product term (next a) next b))))

#|

(define (wallis-method num-terms)
  ...
  (product ?term ?a ?next num-terms))

(define (wallis-method num-terms)
  ...
  (product ?term 0 add1 num-terms))

|#


(define (wallis-method-for-pi num-terms)
  ;; as the desired number of terms increases, so does the accuracy.
  (* 4
     (product wallis-term 0 add1 num-terms)))

(define (wallis-term n)
  (cond [(even? n) (/ (+ 2 n)
                      (+ 3 n))]
        [else
         (/ (+ 3 n)
            (+ 2 n))]))

(require rackunit)
(check-eqv? (wallis-term 0) 2/3)
(check-eqv? (wallis-term 1) 4/3)
(check-eqv? (wallis-term 2) 4/5)
(check-eqv? (wallis-term 3) 6/5)
(check-eqv? (wallis-term 4) 6/7)
