#lang racket/base

(require racket/local
         (only-in racket/math sqr))

(define (cont-frac n d k)
  (define (step i)
    (if (= i k)
        0
        (/ (n i)
           (+ (d i)
              (step (add1 i))))))
  (step 0))

(define (tan-cf x k)
  (cont-frac (λ (i)
               (if (zero? i) ; vs `(= i 1)`? Stylistically, is there a reason to prefer one over the other?
                   x
                   (- (sqr x))))
             (λ (i)
               (sub1 (* 2 (add1 i)))) ; odd numbers
             k))
