#lang racket/base

(require (only-in "jtilles/prelude.rkt"
                  difference
                  average)
         racket/local)

(define (search func neg-point pos-point)
  (let ([midpoint (average neg-point pos-point)])
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ([test-value (func midpoint)])
          (cond [(positive? test-value) (search func neg-point midpoint)]
                [(negative? test-value) (search func midpoint  pos-point)]
                [else midpoint])))))
;; CONTRACT: (and (0 . > . (func neg-point)) (0 . < . (func pos-point)))
;; @todo

(define (close-enough? x y)
  (< (difference x y) 0.001))

(define (half-interval-method f a b)
  (let ([a-value (f a)]
        [b-value (f b)])
    (cond [(and (negative? a-value) (positive? b-value))
           (search f a b)]
          [(and (negative? b-value) (positive? a-value))
           (search f b a)]
          [else
           (error "Values are not of opposite sign" a b)])))

(define tolerance 1e-5)

(define (fixed-point func first-guess)
  (local [(define (close-enough? v1 v2)
            (tolerance . > . (difference v1 v2)))
          (define (try guess)
            (let ([next (func guess)])
              (if (close-enough? guess next)
                  next
                  (try next))))] ;; Note the tail recursion
    (try first-guess)))

(require rackunit)

(let ([golden-ratio (/ (+ 1 (sqrt 5))
                       2)])
  (check-= golden-ratio
           (fixed-point (λ (x) (+ 1 (/ x)))
                        5) ;; I don't think the number that you pick actually matters...
           tolerance))
