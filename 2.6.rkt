#lang racket

(require (only-in racket/function identity))
(define zero
  (λ (_) identity))

(define (add-1 n)
  (λ (f)
    (λ (x)
      (f
       ((n f) x)))))

(add-1 zero)

(λ (f)
  (λ (x)
    (f
     ((zero f) x))))

(λ (f)
  (λ (x)
    (f
     (identity x))))


(λ (f)
  (λ (x)
    (f x)))

(define one
  (λ (g)
    (λ (y)
      (g y))))

(add-1 one)

(λ (f)
  (λ (x)
    (f
     ((one f) x))))

(λ (f)
  (λ (x)
    (f
     (((λ (g)
         (λ (y)
           (g y)))
       f) x))))

(λ (f)
  (λ (x)
    (f
     ((λ (y)
        (f y))
      x))))

(λ (f)
  (λ (x)
    (f
     (f x))))

(define two
  (λ (h)
    (λ (z)
      (h (h z)))))

(add one two)
; SHOULD evaluate to...
(λ (f)
  (λ (x)
    (f (f (f x)))))
; right?

(define (add m n)
  (λ (f)
    (λ (x)
      ((n (m f)) x))))
;; could also be `((m (n f)) x)` I'm pretty sure

(add one two)

(λ (f)
  (λ (x)
    ((two (one f)) x)))

(λ (f)
  (λ (x)
    ((two (λ (y)
            (f y))) x)))

(λ (f)
  (λ (x)
    (((λ (h)
        (λ (z)
          (h (h z))))
      (λ (y)
        (f y)))
     x)))

(λ (f)
  (λ (x)
    ((λ (z)
       ((λ (y)
          (f y))
        ((λ (y)
           (f y))
         z)))
     x)))

(λ (f)
  (λ (x)
    ((λ (z)
       ((λ (y)
          (f y))
        ((λ (y)
           (f y))
         z)))
     x)))

(λ (f)
  (λ (x)
    ((λ (y)
       (f y))
     ((λ (y)
        (f y))
      x))))

(λ (f)
  (λ (x)
    (f
     ((λ (y)
        (f y))
      x))))

(λ (f)
  (λ (x)
    (f
     ((λ (y)
        (f y))
      x))))



;;; ABORT

#|
(define (add-1 n)
  (λ (f)
    (λ (x)
      (f
       ((n f) x)))))
|#


;;; I just realized:
(= (λ (n) (add one n))
   add-1)




(λ (n) (add one n))

(λ (n)
  (add (λ (g)
         (λ (y)
           (g y)))
       n))

;; so `g` needs to be...
(λ (m)
  ;; ...
  )

#|
(define (add-1 n)
  (λ (f)
    (λ (x)
      (f
       ((n f) x)))))
|#
  
;; ABORT AGAIN

(= (add one zero)
   (add-1 zero)
   one)

(add (λ (g)
       (λ (y)
         (g y)))
     (λ (k)
       (λ (w)
         w)))
;==
(λ (g)
  (λ (y)
    (g y)))

;; If I "give" `zero` anything, it gives me back the identity function.

;==

((λ (m n)
   (λ (f)
     (λ (x)
       ;...
       )))
 one
 zero)
;==
one
;==
(λ (g)
  (λ (y)
    (g y)))

;==?

((λ (m n)
   (λ (f)
     (λ (x)
       (((m n) f) x))))
 one
 zero)
  
(λ (f)
  (λ (x)
    (((one zero) f) x)))

(λ (f)
  (λ (x)
    (((
       
       one
       
       zero) f) x)))

(λ (f)
  (λ (x)
    (((
       
       (λ (g)
         (λ (y)
           (g y)))
       
       zero) f) x)))

(λ (f)
  (λ (x)
    ((
      
      ((λ (g)
         (λ (y)
           (g y)))
       zero)
      
      f) x)))

(λ (f)
  (λ (x)
    ((
      
      (λ (y)
        (zero y))
      
      f) x)))

(λ (f)
  (λ (x)
    (
     
     ((λ (y)
        (zero y))
      f)
     
     x)))

(λ (f)
  (λ (x)
    (
     
     (zero f)
     
     x)))

(λ (f)
  (λ (x)
    (
     
     (zero f)
     
     x)))




;;;; ^L

;;;; # Actual solution
;;; (restarted again, though
(define !zero (λ (f)
               (λ (x) x)))

(define (add-1 n)
  (λ (f)
    (λ (x)
      (f ((n f) x)))))

(add-1 !zero)

(λ (f)
  (λ (x)
    (f ((!zero f) x))))

(λ (f)
  (λ (x)
    (f x)))

(define zero (λ (_) identity))
(define one identity)


(add-1 one)

(λ (f)
  (λ (x)
    (f ((identity f) x))))

(define (double f)
  (λ (x)
    (f (f x))))

(define two double)

#;
(define (add m n)
  (λ (f)
    (λ (x)
      ;...
      ((m f) x)
      ;...
      )))
#;
(define (add m n)
  (λ (f)
    (λ (x)
      
      ((m (n f)) x)

      )))
    
#;(add two two)
;; should equal four


;; do some isabelle

#|

theory Scratch
imports "~~/src/HOL/HOL"
begin

definition  "zero ≡ λf. λx. x"
definition "add1 n ≡ λf. λx. (f ((n f) x))"
value "add1 zero" (* "λu. u" *)
(* definition "one ≡ λf. f" *)
definition "one ≡ λf. λx. f x"
definition "two ≡ λf x. f (f x)"
value "add1 two"

(*
definition "add ≡ (λm n. (λf. (λx. ((m (n f)) x))))"
value "add zero one" (* "λu ua. ua" *)
*)

definition "add m n ≡ λf x. ((m f) ((n f) x))"
value "add zero one"
value "add two two" (* "λu ua. u (u (u (u ua)))" *)


|#

(define (add m n)
  (λ (f)
    (λ (x)
      ((m f) ((n f) x)))))

(define (add++ m n)
  (λ (f)
    (compose (m f) (n f))))

(((add++ two two) add1) 1)
;= 5

(define add-expanded
  (λ (m n)
    (λ (f)
      (λ (x)
        ((m f)
         ((n f) x))))))