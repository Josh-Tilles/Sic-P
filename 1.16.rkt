#lang racket/base
(require (only-in racket/math
                  sqr)
         (only-in "jtilles/prelude.rkt"
                  half))

(define (fast-and-svelte-expt b n)
  ;; `b` for "base", and `n` for... "natural"? "number"? I dunno.
  (if (zero? n)
      1
      (let recur ([a 1] [b b] [n n])
        ;; a * b^n should remain a constant. I.e., that quantity doesn't vary over the iterations.
        (cond [(= 1 n)   (* a b)]
              [(even? n) (recur a (sqr b) (half n))]
              [else ;; n is odd
               (recur (* a b) b (sub1 n))]))))

(require rackunit)
(check-eq? 1 (fast-and-svelte-expt 3 0))
(check-eq? 3 (fast-and-svelte-expt 3 1))
;; the above two tests really could be expressed as properties...
(check-eq? 9 (fast-and-svelte-expt 3 2))
(check-eq? 27 (fast-and-svelte-expt 3 3))
(check-eq? 4 (fast-and-svelte-expt 2 2))
(check-eq? (expt 9 10) ;= 3486784401
           (fast-and-svelte-expt 9 10))

;;; @TODO It would be cool to provide a contract on this function that guaranteed its execution pattern. Like, that it executes in O(log(n)) time, or constant space.
