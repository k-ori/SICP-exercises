(load "ch4-analyzingmceval.scm")

;;; Ex 4.22

(define (analyze-4.22 exp)
  (cond ((self-evaluating? exp)
	 ;; 
	 ((let? exp) (analyze-4.22 (let->combination exp)))
	 ;;
	 )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `eval` extended by exercises
(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
	((let? exp) (analyze-4.22 (let->combination exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define the-global-environment (setup-environment))
(driver-loop)
