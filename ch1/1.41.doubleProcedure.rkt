#lang planet neil/sicp


(define (double  f)
  (lambda (x ) (f (f x))))

((double inc) 3)

(((double (double double)) inc ) 5)
; 21-5 = 16