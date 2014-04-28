#lang racket/base

(require
 (only-in "jtilles/prelude.rkt"
          double 
          halve)
 racket/local)

(define (iterative-mult a b)
  (local [(define (step n a b) ;; N.B. `a` and `b` are _shadowed_. That is, this internal definition did not close over the outer `a` and `b`. Under other circumstances I might have chosen different names, but I wanted to remind you about this.
            (cond [(= 1 b) (+ n a)]
                  [(even? b) (step n 
                                   (double a) 
                                   (halve b))]
                  [(odd? b) (step (+ n a)
                                  a
                                  (sub1 b))]))]
    ;; The invariant here is the quantity $n + (a * b)$. (see below for example)
    (if (zero? b)
        0
        (step 0 a b))))

    #|
EXAMPLE: 
a = 2, b = 15, so `step` will be called first with n = 0, x = a = 2, y = b = 15
It will then call itself with n = 2, a = 2, and b = 14. Note that n + (a*b) = 2 + (2*14) = 2 * 15
On the next iteration, n = 2, a = 4, and b = 7
Next, n = 6, a = 4, and b = 6
Next, n = 6, a = 8, and b = 3
Next, n = 14, a = 8, and b = 2
Next, n = 14, a = 16, and b = 1
The result is a + n which is 30.

One way to think about n is as a sum of snapshots of a. It's a way for us to capture the remainder
when we can't move shift the ratios between a and b cleanly. Regarding the 
shifting-while-maintaining-invariant: I think of it like squishing different parts of a balloon, 
and having it change shape without changing volume.
    |#


(require rackunit)
(check-eq? (* 2 15) (iterative-mult 2 15))
