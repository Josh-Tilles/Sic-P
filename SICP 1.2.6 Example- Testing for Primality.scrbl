#lang scribble/lp

I'm copying and pasting from the text willy-nilly because I think it's OK to do so because http://creativecommons.org/licenses/by-nc/3.0/

One way to test if a number is prime is to find the number’s divisors. The following program finds the smallest integral divisor (greater than 1) of a given number n. It does this in a straightforward way, by testing n for divisibility by successive integers starting with 2.
@chunk[<arbitrary-name>
       <arbitrary-name-dependencies>
       (define (smallest-divisor n) (find-divisor n 2))
       (define (find-divisor n test-divisor)
         (cond [(n . < . (sqr test-divisor)) n]
               [(divides? test-divisor n) test-divisor]
               [else (find-divisor n (add1 test-divisor))]))
       (define (divides? a b) (zero? (remainder b a)))]
       
@chunk[<arbitrary-name-dependencies>
       (require racket/math)
       (define (halve x) (x . / . 2))]

We can test whether a number is prime as follows: $n$ is prime if and only if $n$ is its own smallest divisor.

@chunk[<first-prime-defn>
       (define (prime? n)
         (= n (smallest-divisor n)))]

We need a procedure that computes the exponential of a number modulo another number:
@chunk[<expmod>
       (define (expmod base exp m)
         (cond [(zero? exp) 1]
               [(even? exp)
                (remainder
                 (square (expmod base (halve exp 2) m))
                 m)]
               [else
                (remainder
                 (* base (expmod base (sub1 exp) m))
                 m)]))]

@chunk[<fermat-test>
       (define (fermat-test n)
         (define (try-it a)
           (= (expmod a n n) a))
         (try-it (add1 (random (sub1 n)))))]

The following procedure runs the test a given number of times, as specified by a parameter. Its value is true if the test succeeds every time, and false otherwise.

@chunk[<fast-prime>
       (define (fast-prime? n times)
         (cond [(zero? times) true]
               [(fermat-test n) (fast-prime? n (sub1 times))]
               [else false]))]
