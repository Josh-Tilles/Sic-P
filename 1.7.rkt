#lang racket/base

(require
  (only-in racket/math
           sqr))

;;; The "naive" implementations of functions are given in the comments (primarily so I can refer to them easily while writing the exercise)

#|
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
|#

(define (improve guess x)
  (average guess (x . / . guess)))

;; (define (average x y)
;;   (/ (+ x y)
;;      2))
(define half (λ (n) (n . / . 2)))

(define (average x y)
  (half (+ x y)))

;; (define (good-enough? guess x)
;;   (< (abs (- (square guess) x)) 0.001))

(define (difference x y)
  (abs (x . - . y)))

#|
(define (good-enough? guess x)
  (0.001 . > . (difference x (square guess))))
|#

(define (sqrt x)
  (sqrt-iter (- x) 1.0 x))


;;; Exercise 1.7
(define (good-enough? prev-guess curr-guess)
  (0.001 . > . (/ (difference prev-guess curr-guess)
                  curr-guess            ; or should it be prev-guess here instead?
                  )))

(define (sqrt-iter prev curr x)
  (if (good-enough? prev curr)
      curr
      (sqrt-iter curr
                 (improve curr x)
                 x)))
