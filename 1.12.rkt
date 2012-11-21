#lang racket

(define (pascal r c)
  (if (or (zero? c) (= c r))
      1
      (+ (pascal (sub1 r) c)
         (pascal (sub1 r) (sub1 c)))))

(provide
 (contract-out
  [pascal (->i ([row natural-number/c]
                [column {row} (and/c natural-number/c
                                     (λ (col)
                                       (col . <= . row)))])
               [result natural-number/c])]))

(require rackunit)
(check-eq? (pascal 0 0) 1)
(check-eq? (pascal 3 1) 3)
(check-eq? (pascal 5 2) 10)
(check-eq? (pascal 10 10) 1)
(check-eq? (pascal 10 9) 10)
