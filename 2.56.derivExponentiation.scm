; load from book
(define (deriv exp var)
(cond ((number? exp) 0)
      ((variable? exp)
       (if (same-variable? exp var) 1 0))
      ((sum? exp)
       (make-sum (deriv (addend exp) var)
                 (deriv (augend exp) var)))
      ((product? exp)
       (make-sum
         (make-product (multiplier exp)
                       (deriv (multiplicand exp) var))
         (make-product (deriv (multiplier exp) var)
                       (multiplicand exp))))
      ((exponentiation? exp)
        (make-product (exponent exp ) (make-exponentiation (base exp )  (- (exponent exp) 1 ) )) 
      )
      (else
       (error "unknown expression type -- DERIV" exp))))

;; representing algebraic expressions

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
(and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
(cond ((=number? a1 0) a2)
      ((=number? a2 0) a1)
      ((and (number? a1) (number? a2)) (+ a1 a2))
      (else (list '+ a1 a2))))

(define (=number? exp num)
(and (number? exp) (= exp num)))

(define (make-product m1 m2)
(cond ((or (=number? m1 0) (=number? m2 0)) 0)
      ((=number? m1 1) m2)
      ((=number? m2 1) m1)
      ((and (number? m1) (number? m2)) (* m1 m2))
      (else (list '* m1 m2))))


; (define (make-sum a1 a2) (list '+ a1 a2))

; (define (make-product m1 m2) (list '* m1 m2))

(define (sum? x)
(and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))


(define (augend s)
     (cond ((equal? '() (cdddr s ))  (caddr s) )
    (else (append '( + ) (cddr s)))))


(define (product? x)
(and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) 
    (cond ((equal? '() (cdddr p ))  (caddr p) )
    (else (append '( * ) (cddr p)))))

;: exponentiation

(define (exponentiation? x) 
    (and (pair? x) (eq? (car x ) '** ))
)

(define (base x) (cadr x))

(define (exponent x) (caddr x))

(define (make-exponentiation base exp)
(cond ((=number? base 0) 0)
        ((=number? base 1 ) 1 )   
        ((=number? exp 0) 1)
        ((=number? exp 1) base)
        (else (list '** base exp ))))

(make-exponentiation  21 3)

(deriv '(* x x x) 'x)
;: (deriv '(+ x 3) 'x)
;: (deriv '(* x y) 'x)
 (deriv '(* (* x y) (+ x 3)) 'x)
 (deriv '(*  x y (+ x 3)) 'x)

(deriv '(** x 76) 'x)
;; With simplification


;: (deriv '(+ x 3) 'x)
;: (deriv '(* x y) 'x)
;: (deriv '(* (* x y) (+ x 3)) 'x)


;; EXERCISE 2.57
; (deriv '(* x y (+ x 3)) 'x)



