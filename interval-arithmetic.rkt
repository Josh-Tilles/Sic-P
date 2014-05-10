#lang racket

(require
 (only-in "jtilles/prelude.rkt"
          half-of
          difference))

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
  (let ([y-recip (make-interval (/ 1 (upper-bound y))
                                (/ 1 (lower-bound y)))])
    (mul-interval x y-recip)))

(define (make-interval a b)
  (cons a b))

;;; Exercise 2.7
(define (upper-bound interval)
  (car interval))
(define (lower-bound interval)
  (cdr interval))


;;; Exercise 2.8
;; Well, the minimum result occurs when the subtrahend is at the upper-bound,
;; and the minuend is at the lower-bound. The maximum result occurs vice-versa.
(define (sub-interval x y)
  (make-interval
   (- (lower-bound x)
      (upper-bound y))

   (- (upper-bound x)
      (lower-bound y))))


;;; Exercise 2.9
(define (interval-width i)
  (half-of (difference (lower-bound i)
                       (upper-bound i))))

(make-interval 6.12  7.48)
(make-interval 4.465 4.935)
