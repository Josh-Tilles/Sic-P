(define (make-serializer)
  (let ([mutex (make-mutex)])
    (lambda (proc)
      (define (serialized-proc . args)
        (mutex 'acquire)
        (let ([val (apply proc args)])
          (mutex 'release)
          val))
      serialized-proc)))

(define (make-mutex)
  (let ([cell (list false)])
    (define (the-mutex m)
      (cond [(eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))] ;retry
            [(eq? m 'release) (clear! cell)]))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))
