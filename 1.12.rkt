#lang racket

#| first attempt; ultimately wrong
(define (tri-num r c)
  (cond [(or (zero? r) (zero? c)) 1]
        [(= r c) 1]
        [else (+ (tri-num (sub1 r) c)
                 (tri-num (sub1 r) (add1 c)))]))
|#

(define (pascal r c)
  (if (or (zero? c) (= c r))
      1
      (+ (pascal (sub1 r) c)
         (pascal (sub1 r) (sub1 c)))))

(provide
 (contract-out
  [pascal (->i ([row natural-number/c]
                [column (row) ; meaning that the contract for `column` depends on `row`
                        (and/c natural-number/c
                               (λ (col)
                                  (col . <= . row)))])
               [result natural-number/c])])) ;; I believe the `result` identifier can be arbitrarily named.

(require rackunit)

(test-case "The ``edges''of the triangle are all ones."
           (check-equal? (pascal 0 0) 1)
           (check-equal? (pascal 3 3) 1)
           (check-equal? (pascal 4 0) 1))

(check-eq? (pascal 2 1) 2)
(check-eq? (pascal 3 1) 3)
(check-eq? (pascal 4 2) 6)
(check-eq? (pascal 5 2) 10)
(check-eq? (pascal 10 10) 1)
(check-eq? (pascal 10 9) 10)
