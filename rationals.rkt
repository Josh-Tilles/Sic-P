#lang racket

;;; Now we can have the simple syntax of "(define make-rat cons)"
;;; without losing the debugging & tracing conveniences.
(define-syntax-rule (alias new-name old-name)
  (define (new-name . args)
    (apply old-name args)))

(alias make-rational cons)
(alias numer car)
(alias denom cdr)

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat-2 n d)
  (let ([common-denom (gcd n d)])
    (cons (n . / . g)
          (d . / . g))))
