#lang racket/base

(define (cube x) (* x x x))

(define (sum-integers a b)
  (if (a . > . b)
      0
      (+ a (sum-integers (add1 a) b))))

(define (pi-sum a b)
  (if (a . > . b)
      0
      (+ (/ #i1 ;for "inexact". It keeps this from becoming a proper rational number
            (* a (+ a 2)))
         (pi-sum (+ a 4) b))))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1)) ;; same thing as `add1`

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

;;; Here's my first attempt at exercise 29:
#|
;; `num-pieces` is even!
(define (integral-según-Simpson func init upper-bound num-pieces)
  (local [(define h (/ (upper-bound . - . init)
                       num-pieces))
          (define (next a) (+ h a))

          (define (term a)
            (define coefficient (cond [(or (= a 0) (= a upper-bound)) 1]
                                      [(odd? a) 4]
                                      [(even? a) 2]))
            (* coefficient (func a)))]
    (sum term init next upper-bound)))
|#

;;; Oh, and by the way, "según" means "according to" in Spanish


(require racket/local)
(define (integral-según-Simpson func lower-bound upper-bound num-pieces)
  (local [(define h (/ (upper-bound . - . lower-bound)
                       num-pieces))

          (define (term n)
            (let ([coefficient (cond [(or (= n 0) (= n num-pieces)) 1]
                                     [(odd? n) 4]
                                     [(even? n) 2])]
                  [a (+ lower-bound (* n h))])
              (* coefficient (func a))))]
    (* (/ h 3)
       (sum term #i0 add1 num-pieces))))
;; CONTRACT: `num-pieces` is even


(require rackunit)
(require (only-in "jtilles/prelude.rkt" difference))
(check <
       (difference 1/4 (integral-según-Simpson cube 0 1 100))
       (difference 1/4 (integral cube 0 1 0.01)))
(check <
       (difference 1/4 (integral-según-Simpson cube 0 1 1000))
       (difference 1/4 (integral cube 0 1 0.001)))
