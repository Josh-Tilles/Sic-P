#lang racket/base

(define (ackermann x y)
  (cond [(zero? y) 0]
        [(zero? x) (* 2 y)]
        [(= y 1)   2]
        [else      (ackermann (sub1 x)
                              (ackermann x (sub1 y)))]))
;; (ackermann 1 10) = (ackermann 0 (ackermann 1 9))
;;   ... nested (a 0 (a 0 (a 0 (... (a 1 1)))))
;; (ackermann 0 1) = 2
;; (ackermann 0 2) = 4
;; (ackermann 0 4) = 8
;; (ackermann 0 n) = (* 2 n)

;; (ackermann 1 0) = 0
;; (ackermann 1 1) = 2
;;   ! observe that (ackermann 1 1) = (ackermann 0 1)
;; (ackermann 1 2) = (ackermann 0 (ackermann 1 1))
;;                 = (ackermann 0 2)
;;                 = 4
;; (ackermann 1 3) = (ackermann 0 (ackermann 1 2))
;;                 = (ackermann 0 (ackermann 0 (ackermann 1 1)))
;;                 = (ackermann 0 4)
;;                 = 8
;; (ackermann 1 4) = (ackermann 0 (ackermann 1 3))
;;                 = (ackermann 0 8)
;;                 = 16
;; (ackermann 1 n) = (2 . ^ . n)

;; (ackermann 2 0) = 0
;; (ackermann 2 1) = 2
;; (ackermann 2 2) = (ackermann 1 (ackermann 2 1))
;;                 = (ackermann 1 2)
;;                 = 4
;; (ackermann 2 3) = (ackermann 1 (ackermann 2 2))
;;                 = (ackermann 1 4)
;;                 = 16
;; (ackermann 2 4) = (ackermann 1 (ackermann 2 3))
;;                 = (ackermann 1 16)
;;                 = (expt 2 16)
;;                 = 65536
;; (ackermann 2 n) = 2^(2^n
;;                     WRONG
;;                 (ackermann 2 3) != 2^(2^3)
;; correct: 2^2^2^... a tower of twos with a height of n. AKA 2 ↑↑ n

;; (ackermann 3 0) = 0
;; (ackermann 3 1) = 2
;; (ackermann 3 2) = (ackermann 2 (ackermann 3 1))
;;                 = (ackermann 2 2)
;;                 = 4
;; (ackermann 3 3) = (ackermann 2 (ackermann 3 2))
;;                 = (ackermann 2 4)
;;                 = 65536
