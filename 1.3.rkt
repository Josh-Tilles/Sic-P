#lang racket/base

;; First attempt:
#|
(define (square-the-two-largest-then-add-them x y z)
  (if (x . > . y)
      (if (x . > . z)
          (+ (* x x)
             (if (y . > . z)
                 (* y y)
                 (* z z))))
      (+ (* y y)
         (if (x . > . z)
             (* x x)
             (* z z)))))
|#

;; that doesn't look right. Lemme try that again:

(require
  (only-in racket/math
           sqr))

(define (square-the-two-largest-then-add-them x y z)
  (if (x . > . y)
      (+ (sqr x)
         (if (y . > . z)
             (sqr y)
             (sqr z)))
      (+ (sqr y)
         (if (x . > . z)
             (sqr x)
             (sqr z)))))

(require rackunit)
(check-eq? (square-the-two-largest-then-add-them 2 3 4)
           25)
(check-eq? (square-the-two-largest-then-add-them 2 1 3)
           13)
(check-eq? (square-the-two-largest-then-add-them 1 1 1)
           2)
(check-eq? (square-the-two-largest-then-add-them 5 4 3)
           41)