#lang racket

#|  first attempt; ultimately wrong
(define (tri-num r c)
  (cond [(or (zero? r) (zero? c)) 1]
        [(= r c) 1]
        [else (+ (tri-num (sub1 r) c)
                 (tri-num (sub1 r) (add1 c)))]))

|#

(define (tri-num r c)
  (cond [(or (zero? r) (zero? c)) 1]
        [(= r c) 1]
        [else (+ (tri-num (sub1 r) (sub1 c))
                 (tri-num (sub1 r) c))]))

(require rackunit)

(test-case "The ``edges'' of the triangle are all ones."
           (check-equal? (tri-num 0 0) 1)
           (check-equal? (tri-num 3 3) 1)
           (check-equal? (tri-num 4 0) 1))

(check-equal? (tri-num 2 1) 2)
(check-equal? (tri-num 3 1) 3)
(check-equal? (tri-num 3 2) 3)

(check-equal? (tri-num 4 2) 6)