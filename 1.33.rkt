#lang racket

(define (filtered-accumulate combiner filter null-value term a next b)
  (local [(define (iter a result)
            (if (< a b)
                result
                (iter (next a)
                      (combiner result
                                (if (filter (term a))
                                    (term a)
                                    null-value)))))]
    (iter a null-value)))

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate + prime? 0 sqr a add1 b))

(define (product-of-relative-primes n)
  (define (relatively-prime? i)
    (= 1 (gcd i n)))
  (filtered-accumulate * relatively-prime? 1 identity 1 add1 n))
                       
