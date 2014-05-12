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

#;
(module+ |Exercise 2.1|
  (define (make-rat++ n d)
    (let ([common-D (gcd n d)])
      (if (negative? d)
          (cons ((- n) . / . common-D)
                ((- d) . / . common-D))
          (cons (n . / . common-D)
                (d . / . common-D))))))

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

#;
(define-signature rat^
  (make-rat
   (contracted
    #:exists rat
    [numer (rat . -> . number?)]
    [denom (-> any/c number?)])))

(define-signature interval^
  (make-interval
   lower-bound
   upper-bound))

(define-signature interval-arithmetic^
  (add-interval
   mul-interval
   sub-interval
   div-interval))

(define (reciprocal n)
  (1 . / . n))



(define-unit interval-arithmetic@
  (import interval^)
  (export interval-arithmetic^)
  
  (define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))
  
  (define (mul-interval x y)
    (let ([p1 (* (lower-bound x) (lower-bound y))]
          [p2 (* (lower-bound x) (upper-bound y))]
          [p3 (* (upper-bound x) (lower-bound y))]
          [p4 (* (upper-bound x) (upper-bound y))])
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))
  
  (define (div-interval x y)
    (mul-interval x (recip-interval y)))
  
  (define (recip-interval x)
    (make-interval (reciprocal (upper-bound x))
                   (reciprocal (lower-bound x))))
  
  ;; Exercise 2.8
  (define (sub-interval x y)
    (let ([lbx (lower-bound x)] [ubx (upper-bound x)]
          [lby (lower-bound y)] [uby (upper-bound y)])
      (make-interval (lbx . - . uby)
                     (ubx . - . lby)))))

(define-unit pair-as-interval@
  (import)
  (export interval^)
  (define (make-interval a b) (cons a b))
  
  ;; Exercise 2.7
  (define (lower-bound x) (car x))
  (define (upper-bound x) (cdr x)))

(module+ |Exercise 2.9|
  
  (define-values/invoke-unit/infer pair-as-interval@)
  (define-values/invoke-unit/infer interval-arithmetic@)
  
  (define (width x)
    (half-of (difference (upper-bound x)
                         (lower-bound x))))
  
  (define a (make-interval 3.5 4))
  (define b (make-interval 7 13))
  
  (width a) ;= 0.25
  (width b) ;= 3
  
  (width (add-interval a b))
  )
#|
View the above by executing in a REPL:
```racket
(require (submod "." |Exercise 2.9|))
```
|#
