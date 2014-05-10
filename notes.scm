;; 1.1.6

;; the first, and most basic, definition
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

;; an alternative, more concise definition
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

;; yet another
(define (abs x)
  (if (< x 0)
      (- x)
      x))


;; However, `abs` is actually defined in the base library! (at least
;; for R7RS. I'm not sure when it was introduced)
;; ... Hm. I'm going to say that "provided by" is better than "defined
;; in" in this case.
;; N.B. the difference between something being built-in by being
;; "provided" and being built-in by being "primitive".
;; (Cf. the role of axioms vs assumptions??)
