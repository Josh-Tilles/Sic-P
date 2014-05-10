#lang racket/base
(require racket/local
         (only-in racket/math sqr)
         (only-in racket/function identity))

;(require ...)
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond [(n . < . (sqr test-divisor)) n]
        [(divides? test-divisor n) test-divisor]
        [else (find-divisor n (add1 test-divisor))]))
(define (divides? a b) (zero? (remainder b a)))
(define (prime? n)
  (= n (smallest-divisor n)))
;; (we needed a `prime?` procedure)


(define (filtered-accumulate combiner filter null-value term a next b)
  (local [(define (iter a result)
            (if (> a b)
                result
                (iter (next a)
                      (combiner result
                                (if (filter (term a))
                                    (term a)
                                    null-value)))))]
    (iter a null-value)))

(define (filtered-accumulate2 combiner filter null-value term a next b)
  (let iter ([i a] [result null-value])
    (if (i . > . b)
        result
        (let ([val (if (filter (term i))
                       (term i)
                       null-value)])
          (iter (next i)
                (combiner result val))))))

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate + prime? 0 sqr a add1 b))

(define (product-of-relative-primes n)
  (define (relatively-prime? i)
    (= 1 (gcd i n)))
  (filtered-accumulate * relatively-prime? 1 identity 1 add1 n))
