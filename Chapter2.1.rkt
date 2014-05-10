#lang racket

(require (only-in "jtilles/prelude.rkt" half half-of difference))

(define-signature rational-number^
  (make-rat
   numer
   denom))

;; CONTRACT: if x is (make-rat n d), then (= (/ (numer x) (denom x)) (/ n d))

(define-unit pairs-as-rats@
  (import)
  (export rational-number^)
  
  (define (make-rat n d)
    (cons n d))
  
  (define (numer x)
    (car x))
  
  (define (denom x)
    (cdr x)))

(require (only-in "jtilles/prelude.rkt" define-alias))
(define-unit pairs-as-rats2@
  (import)
  (export rational-number^)
  (define-alias make-rat cons)
  (define-alias numer car)
  (define-alias denom cdr))

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

(define-values/invoke-unit/infer pairs-as-rats@)
(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

(define-values/invoke-unit/infer rational-arithmetic@)

(module+ |Exercise 2.1|
  (define (make-rat++ n d)
    (let ([common-D (gcd n d)])
      (if (negative? d)
          (cons ((- n) . / . common-D)
                ((- d) . / . common-D))
          (cons (n . / . common-D)
                (d . / . common-D))))))

(define-unit pairs-as-rats3@
  (import)
  (export rational-number^)
  (define-alias numer car)
  (define-alias denom cdr)
  (define (make-rat n d)
    (let ([common-D (gcd n d)])
      (if (negative? d)
          (cons ((- n) . / . common-D)
                ((- d) . / . common-D))
          (cons (n . / . common-D)
                (d . / . common-D))))))





;; @TODO alternatively, use structs? (NO: too concrete! so, at least, not *yet*)

(define-signature segment^ (make-segment start-segment end-segment))




(define-signature point^ (make-point x-point y-point))

(module coordinate-sig racket/signature/lang
  make-point
  x-point
  y-point)

(module segment racket/signature/lang
  make-segment
  start-segment
  end-segment)


#;
(module rational-number-sig racket/signature/lang
  (contracted
   [make-rat (->)]
   [numer (any/c . -> . number?)]
   [denom (any/c . -> . number?)]))

(define-signature rat^
  (make-rat
   (contracted
    #:exists rat
    [numer (rat . -> . number?)]
    [denom (-> any/c number?)])))
