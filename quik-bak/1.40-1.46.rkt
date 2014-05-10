#lang racket/base

(define (newton f guess)
  (define df (deriv f))
  (fixed-point
   (λ (x) (- x (/ (f x)
                  (df x))))
   guess))

(require rackunit)

; (module fixed-point
(require (only-in "jtilles/prelude.rkt"
                  difference
                  average))
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
; ) ;end-module

; (require 'fixed-point)

(define (average-damp f)
  (λ (x) (average x (f x))))

(check-eq? 55 ((average-damp sqr) 10))

(define (alt-square-root x)
  (fixed-point (average-damp (λ (y) (x . / . y)))
               #i1))

(define (alt-cube-root x)
  (fixed-point (average-damp (λ (y) (x . / . (sqr y))))
               #i1))

(define deriv
  (λ (f)
    (λ (x)
      (/ (- (f (+ x dx))
            (f x))
         dx))))

(define (deriv g)
  (λ (x) (/ (- (g (+ x dx))
               (g x))
            dx)))

(define dx 1e-5)

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x)
            ((deriv g) x)))))

(define (newtons-method f guess)
  (fixed-point (newton-transform f) guess))



#|
;; use newtons-method to approximate zeros of the cubic x^3 + ax^2 + bx + c
(define (cubic a b c)
  ...)
|#
;; 41
(define (cubic a b c)
  (lambda (x)
    (+ (x . expt . 3)
       (* a (sqr x))
       (* b x)
       c)))



(define (double f)
  (λ (x)
    (f (f x))))

;; 42
(define (compose g f)
  (λ (x)
    (g (f x))))

(check-eq? ((compose sqr add1) 6)
           49)

;;; Exercise 1.43

#| First attempt; wrong
(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f)
                (sub1 n))))
|#

(define (repeated f n)
  (let iter ([result-func identity]
             [n n])
    (if (= n 1)
        result-func
        (iter (compose f result-func)
              (sub1 n)))))
