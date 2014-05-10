#lang racket

(define (half n)
  (n . / . 2))

(define (difference x y)
  (abs (- x y)))

;;; Now we can have the simple syntax of "(define make-rat cons)"
;;; without losing the debugging & tracing conveniences.
(define-syntax-rule (alias new-name old-name)
  (define (new-name . args)
    (apply old-name args)))

(alias make-rational cons)
(alias numer car)
(alias denom cdr)

(alias diff difference)
(define diff-alt (compose abs -))


;;; If the rational number is positive, both the numerator and denominator
;;;  are positive.
;;; If the rational is negative, only the numerator is negative.
(define (make-rat++ n d)
  ;; There are four possible combinations: +n +d, +n -d, -n +d, -n -d.
  ;; The first and third require no changes.
  ;; The second and fourth are both acceptable after each of the
  ;;  components have been multiplied by negative one.
  (let ([common-d (gcd n d)])
    (if (negative? d)
        (cons ((- n) . / . common-d)
              ((- d) . / . common-d))
        (cons (n . / . common-d)
              (d . / . common-d)))))
;;; I'd rather have done something like Clojure's (let [[x y] (if (neg? d) [(- x) (- y)] [x y]) ...)
;;; Also interesting: in Clojure this probably would have been a map/dict because you
;;; get free :numer and :denom functions.







;;; Each line segment in a plane is represented as a pair of points: a starting point and an ending point.

(define (make-segment point-A point-B)
  (cons point-A point-B))
;; "line-segment" instead of "make-segment"?

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;;; Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate.
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


(define (midpoint-segment s)
  (define (avg a b)
    (half (+ a b)))
  (let ([p1 (start-segment s)]
        [p2 (end-segment s)])
    (make-point (avg (x-point p1) (x-point p2))
                (avg (y-point p1) (y-point p2)))))
;; should be either "midpoint-of-segment" or "segment-midpoint"


(define (rect-area r)
  (* (rect-base r)
     (rect-height r)))

(define (rect-perim r)
  (+ (* 2 (rect-base r))
     (* 2 (rect-height r))))

(define (make-rectangle b h)
  (cons b h))

(define (rect-base r)
  (car r))

(define (rect-height r)
  (cdr r))

(define (make-rect-with-segment s)
  s)

(define (seg-rect-base s)
  (let ([p1 (start-segment s)]
        [p2 (end-segment s)])
    (diff (x-point p1)
          (x-point p2))))

(define (seg-rect-height s)
  (let ([p1 (start-segment s)]
        [p2 (end-segment s)])
    (diff (y-point p1)
          (y-point p2))))





(define (alt-cons x y)
  (define (dispatch m)
    (cond [(= m 0) x]
          [(= m 1) y]
          [else (error "Argument not 0 or 1:" m)]))
  dispatch)

(define (alt-car z) (z 0))

(define (alt-cdr z) (z 1))

(define (lambda-cons x y)
  (λ (m) (m x y)))
(define (lambda-car z)
  (z (λ (p q) p)))
;;; Exercise 2.4
(define (lambda-cdr z) 
  (z (λ (p q) q)))


;;; Exercise 2.5
(define (numeric-cons a b)
  (* (2 . expt . a)
     (3 . expt . b)))
;; well, (numeric-cons 4 2) => (* 2^4 3^2) => 171
;; (numeric-car 171) SHOULD equal 4
(define (divides? d n)
  (zero? (remainder n d)))
(define (extract-all n)
  (λ (x)
    (let iter ([x x])
      (if (n . divides? . x)
          (iter (/ x
                   n))
          x))))

(define extract-all-twos (extract-all 2))
(define extract-all-threes (extract-all 3))
          
(define (numeric-car the-cons)
  (let iter ([a 0] [c the-cons])
    (cond [(zero? (remainder c
                             2))
           (iter (add1 a) (/ c
                             2))]
          [(zero? (remainder c 3)) (iter a ;no add1!
                                         (/ c 3))]
          [(= c 1) a])))

(define (numeric-cdr the-cons)
  (
  
  
