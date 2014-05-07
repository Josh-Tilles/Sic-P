#lang racket/base
(require rackunit
         (only-in racket/math sqr))

(define (compose f g)
  (λ (x)
    (f (g x))))

(let ([square sqr]
      [inc add1])
  (check-equal? ((compose square inc) 6)
                49))
