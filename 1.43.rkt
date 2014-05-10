#lang racket/base
(require rackunit
         (only-in racket/math sqr)
         (only-in "1.42.rkt" compose) ; even though 1.42 only exports a single procedure, I'm *explicitly* importing it because `compose` is actually a part of `racket/base`.
         )
(provide repeated)

(define (repeated f n)
  ;; @todo CONTRACT: `n` is a positive integer
  (let iter ([i 1] [result-func f])
    (if (= i n)
        result-func
        (iter (add1 i)
              (compose f result-func)))))


(let ([square sqr])
  (check-equal? ((repeated square 2) 5)
                625))