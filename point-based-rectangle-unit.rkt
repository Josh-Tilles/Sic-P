#lang racket

(require "rectangle-sig.rkt")

(define-unit point-based-rectangle@
  (import)
  (export rectangle^)
  
  (define (area r))
  (define (perim r)))

(provide point-based-rectangle@)