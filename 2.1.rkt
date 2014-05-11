#lang racket

(define-signature rational-number^
  (make-rat
   numer
   denom))

(define-signature rational-arithmetic^
  (add-rat
   sub-rat
   mul-rat
   div-rat
   equal-rat?))

(define-unit rational-arithmetic@
  (import rational-number^)
  (export rational-arithmetic^)
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (equal-rat? x y)
    (= (* (numer x) (denom y))
       (* (numer y) (denom x)))))

(define-unit pairs-as-rats@
  (import)
  (export rational-number^)

  ;;;; Exercise 2.1
  ;;; If the rational number is positive, both the numerator and denominator
  ;;;  are positive.
  ;;; If the rational is negative, only the numerator is negative.
  (define (make-rat n d)
    ;; There are four possible combinations: +n +d, +n -d, -n +d, -n -d.
    ;; The first and third require no changes.
    ;; The second and fourth are both acceptable after each of the
    ;;  components have been multiplied by negative one.
    (let ([common-D (gcd n d)])
      (if (negative? d)
          (cons ((- n) . / . common-D)
                ((- d) . / . common-D))
          (cons (n . / . common-D)
                (d . / . common-D)))))
  ;;; I'd rather have done something like Clojure's `(let [[x y] (if (neg? d) [(- x) (- y)] [x y]) ...)`
  ;;; Also interesting: in Clojure this probably would have been a map/dict because you
  ;;; get free :numer and :denom functions.

  (define (numer x)
    (car x))

  (define (denom x)
    (cdr x)))

(define-values/invoke-unit/infer pairs-as-rats@)
(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))
