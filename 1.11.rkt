#lang racket/base
(require racket/local)

(require rackunit)
(define (exec-specs func)
  (check-eq? (func 0) 0)
  (check-eq? (func 1) 1)
  (check-eq? (func 2) 2)
  (check-eq? (func 3) 4)
  (check-eq? (func 4) 11)
  (check-eq? (func 5) 25)
  (check-eq? (func 6) 59))

(define (recursive-F n)
  (if (n . < . 3)
      n
      (+      (recursive-F (n . - . 1))
         (* 2 (recursive-F (n . - . 2)))
         (* 3 (recursive-F (n . - . 3))))))

(test-case "Implement the recursive version correctly. Also, demonstrate the existence of coherent & consistent tests"
           (exec-specs recursive-F))

;; First attempt
(define (iterative-F1 n)
  (local [(define (iterate index ultimate penultimate antepenultimate)
            (if (index . >= . n)
                (+ ultimate (* 2 penultimate) (* 3 antepenultimate))
                (iterate (add1 index)
                         n
                         (* 2 ultimate)
                         (* 3 penultimate))))]
    (if (n . < . 3)
        n
        (iterate 3 2 1 0))))

;; Okay, that didn't work... let's revisit the problem:

;;; (func 3)  =>  (+ (func 2) (* 2 (func 1)) (* 3 (func 0)))
;;;           =>  (+ 2        (* 2 1)        (* 3 0))
;;;           =>  4
;;; (func 4)  =>  (+ (func 3) (* 2 (func 2)) (* 3 (func 1)))
;;;           =>  (+ !4       (* 2 !2)       (* 3 !1)
;;;           =>  (+ 4        4              3)
;;;           =>  11
;;; (func 5)  =>  (+ (func 4) (* 2 (func 3)) (* 3 (func 2)))
;;;           =>  (+ !11      (* 2 !4)       (* 3 !2))
;;; (func 6)  =>  (+ (func 5) (* 2 (func 4)) (* 3 (func 3)))
;;;           =>  (+ (func 5) (* 2 (func 4)) (* 3 (func

(define (iterative-F2 n)
  (local [(define (iterate index ultimate penultimate antepenultimate)
            (if (index . >= . n)
                (combine ultimate penultimate antepenultimate)
                (iterate (add1 index)
                         (combine ultimate penultimate antepenultimate)
                         ultimate
                         penultimate)))
          (define (combine a b c)
            (+ a (* 2 b) (* 3 c)))]
    (if (n . < . 3)
        n
        (iterate 3 2 1 0))))

;; #2 was correct, but I just *like* this arrangement better
(define (iterative-F n)
  (cond
    [(n . < . 3)  n]
    [else                  ; Right now, I just happen to think `idx` is hella ugly.
     (local [(define (iter index prev two-ago three-ago)
               (let ([combined (+ prev (* 2 two-ago) (* 3 three-ago))])
                 (if (index . >= . n)
                     combined
                     (iter (add1 index) combined prev two-ago))))] ;N.B. the tail-call position
       (iter 3 2 1 0))]))

(test-case "Implement the iterative version."
           (exec-specs iterative-F))
