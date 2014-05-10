#lang racket/base

(provide define-alias
         half halve half-of
         difference diff diff-alt
         average double)

;;; Now we can have the simple syntax of "(define make-rat cons)"
;;; without losing the debugging & tracing conveniences.
(define-syntax-rule (define-alias new-name old-name)
  (define (new-name . args)
    (apply old-name args)))
;;; @TODO I would also consider using `alias!`

(define (half n)
  (n . / . 2))
(define-alias halve half)
(define-alias half-of half)
;; Because I just don't know what the good name is.

(define (difference x y)
  (abs (- x y)))
(define-alias diff difference)

(define diff-alt (compose1 abs -)) ;; an alternative implementation; written in point-free style


(define (average x y)
  (half-of (+ x y)))


(define (double x)
  (arithmetic-shift x 1))
