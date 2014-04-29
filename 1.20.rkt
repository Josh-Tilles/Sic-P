#lang racket

#|
(if (= ?b 0)
    ?a
    (gcd ?b (remainder ?a ?b)))
|#

(gcd 206 40)

;; ?a := 206
;; ?b := 40
(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(if #f
    206
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

;; ?a := 40
;; ?b := (remainder 206 40)
(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= 6 0) ; first application
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(if #f
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(gcd (remainder 206 40)
     (remainder 40 (remainder 206 40)))

;; ?a := (remainder 206 40)
;; ?b := (remainder 40 (remainder 206 40))
(if (= (remainder 40
                  (remainder 206 40))
       0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))

(if (= (remainder 40
                  6) ; second application
       0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))

(if (= 4 ; third application
       0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))

(if #f
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))

(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40)
                  (remainder 40 (remainder 206 40)))
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

(if (= (remainder 6 ; fourth application
                  (remainder 40 (remainder 206 40)))
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

;; N.B. I could have evaluated the second argument-expression instead of the first!

(if (= (remainder 6
                  (remainder 40 6)) ; fifth application
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

(if (= (remainder 6
                  4) ; sixth application
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

(if (= 2 ; seventh application
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

(if #f
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

(gcd (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40))
                  (remainder (remainder 206 40)
                             (remainder 40 (remainder 206 40))))
       0)
    (remainder (remainder 206 40)
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40 (remainder 206 40)))))))

(if (= 0 ; plus seven more applications
       0)
    (remainder (remainder 206 40)
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40 (remainder 206 40)))))))

;; We're now at fourteen

(if #t
    (remainder (remainder 206 40)
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40 (remainder 206 40)))))))

(remainder (remainder 206 40)
           (remainder 40 (remainder 206 40)))

2 ; plus another four...
; brings us to a total of eighteen.


;;; Applicative order executes `remainder` four times.
(gcd 206 40)

;; ?a := 206
;; ?b := 40
(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(if #f
    206
    (gcd 40 (remainder 206 40)))

;; begins very similarly to normal order

(gcd 40 (remainder 206 40))

(gcd 40 6) ; first application

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(if #f
    40
    (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6))

(gcd 6 4) ; second application

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4)))

(if #f
    6
    (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))

(gcd 4 2) ; third application

(if (= 2 0)
    4
    (gcd 2 (remainder 4 2)))

(if #f
    4
    (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))

(gcd 2 0) ; fourth application

(if (= 0 0)
    2
    (gcd 0 (remainder 2 0)))

(if #t
    2
    (gcd 0 (remainder 2 0)))

2
;; four applications in total
