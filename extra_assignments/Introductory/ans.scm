(- 8 9)
;= -1

(> 3.7 4.4)
;= #f

(- (if (> 3 4) 7 10) (/ 16 10))
;= 84/10
;;    (actually it's 42/5)

(define b 13)
; <nothing>
;;    (actually it's #<unspecified>)

13
;= 13

b
;= 13

>
;= #<procedure>
;;   (actually it's #<procedure > (#:optional _ _ . _)>)

(define square (lambda (x) (* x x)))
;= #<unspecified>

square
;= #<procedure square (x)>

(square 13)
;= 169

(square b)
;= 169

(square (square (/ b 1.3)))
;= 10000.0

;;; etc...
