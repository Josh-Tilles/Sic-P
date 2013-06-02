#lang racket

(gcd 206 40)
;=
(gcd 40 (remainder 206 40))
;=
(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
;=
(if (= 6 0) ;first application of `remainder`
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
;=
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
;=
(if (zero? (remainder 40 (remainder 206 40)))
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))
;=
(if (zero? (remainder 40 6)) ;= second application
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))
;=
(if (zero? 4) ;= third application
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))
;=
(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40))))
;=
(if (zero? (remainder (remainder 206 40)
                      (remainder 40 (remainder 206 40))))
    (remainder 40 (remainder 206 40))
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(if (zero? (remainder 6 ;fourth application
                      (remainder 40 (remainder 206 40))))
    (remainder 40 (remainder 206 40))
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(if (zero? (remainder 6
                      (remainder 40 6))) ;= fifth application
    (remainder 40 (remainder 206 40))
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(if (zero? (remainder 6 4)) ;= fifth application
    (remainder 40 (remainder 206 40))
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(if (zero? 2) ;= sixth application
    (remainder 40 (remainder 206 40))
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(gcd (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40 (remainder 206 40))))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))
;=
(if (zero? (remainder (remainder 40 6) ;seventh
                      (remainder (remainder 40 (remainder 206 40))
                                 (remainder (remainder 206 40)
                                            (remainder 40 (remainder 206 40))))))
    (remainder 40 (remainder 206 40))
    ;...
