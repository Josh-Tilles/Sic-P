#lang racket

;;; @TODO give a contract specifying that the argument to `last-pair` is non-empty.

(define (last-pair l)
  (if (empty? (cdr l))
      l
      (last-pair (cdr l))))

;;; @TODO give a RackUnit test on this.