#lang racket/base

(provide cont-frac)

(require
 (only-in "jtilles/prelude.rkt"
          difference)
 racket/local
 (only-in racket/function
          const))

(define (cont-frac n d k)
  (define (step i)
    (if (i . > . k)
        0
        (/ (n i)
           (+ (d i)
              (step (add1 i))))))
  (step 1))

(define (find-suitably-accurate-k)
  (local [(define acceptable-delta 1e-4) ; = within 4 decimal places
          (define golden-ratio (/ (+ 1 (sqrt 5))
                                  2))
          (define (good-enough? k)
            (acceptable-delta . > . (difference (/ golden-ratio)
                                                 (cont-frac (const 1.0)
                                                            (const 1.0)
                                                            k))))
          (define (step i)
            (if (good-enough? i)
                i
                (step (add1 i))))
          ]
    (step 0)))

(find-suitably-accurate-k)
;= 10


(define (iterative-cont-frac n d k)
  (let step ([i k] [res 0])
    (if (zero? i)
        res
        (step (sub1 i)
              (/ (n i)
                 (+ res (d i)))))))

(exact->inexact
 (iterative-cont-frac (const 1)
                      (const 1)
                      12))
;= 0.6180257510729614
