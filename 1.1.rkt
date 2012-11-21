#lang racket

;;; The only notable bit here is the notation I stole from
;;; Programming Clojure (by Chas Emerick, Christophe Grand, and Brian
;;; Carper) for the result of evaluating a "form".

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
