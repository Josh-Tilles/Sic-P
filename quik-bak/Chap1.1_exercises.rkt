#lang racket

(define (geq-1 x y)
  (or (> x y) (= x y)))

(define (geq-2 x y)
  (not (< x y)))

;;; Exercise 1

10
;= 10

(+ 5 3 4)
;= 12

(- 9 1)
;= 8

(/ 6 2)
;= 3

(+ (* 2 4) (- 4 6))
;= 6

(define a 3)
            ; (nothing)

(define b (+ a 1))
                  ; (nothing)

(+ a b (* a b))
;= 19

(= a b)
;= #f

(if (and (> b a) (< b (* a b)))
    b
    a)
;= 4

(cond [(= a 4) 6]
      [(= b 4) (+ 6 7 a)]
      [else 25])
;= 16

(+ 2 (if (> b a) b a))
;= 6

(* (cond [(> a b) a]
         [(< a b) b]
         [else -1])
   (+ a 1))
;= 16



;;; Exercise 2
(define answer-2 (/ (+ 5 4 (- 2
                              (- 3
                                 (+ 6 (/ 4 5)))))
                    (* 3 (- 6 2) (- 2 7))))


(define (ackermann x y)
  (cond [(zero? y) 0]
        [(zero? x) (* 2 x)]
        [(= y 1) 2]
        [else (ackermann (sub1 x)
                         (ackermann x (sub1 y)))]))
