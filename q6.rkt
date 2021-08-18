#lang racket
(require racket/sandbox)
(require racket/exn)
(provide (all-defined-out))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 1: The lazy lists interface ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define cons-lzl cons)

(define empty-lzl empty)

(define empty-lzl? empty?)

(define head car)

(define tail
  (lambda (lz-lst)
    ((cdr lz-lst))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 2: Auxiliary functions for testing ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Signature: check-inf-loop(mission)
; Purpose: check if the result is infinite loop,
;          if so, return 'infinite
;          otherwise the actual result
; Type: [[Empty -> T1] -> Union(T1, Symbol)]
(define check-inf-loop
  (lambda (mission)
    (with-handlers ([exn:fail:resource?
                     (lambda (e)
                       (if (equal? (exn->string e)
                                   "with-limit: out of time\n")
                           'infinite
                           'error))])
      (call-with-limits 1 #f mission))))

; A function that creates an infinite loop
(define (inf x) (inf x))

;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 3: The assignment ;
;;;;;;;;;;;;;;;;;;;;;;;;;;

; Signature: all-subs(long)
; Type: [List(T) -> LZL(List(T))]
; Purpose: compute all lists that can be obtained 
; from long by removing items from it.
; Pre-conditions: -
; Tests:
; (take (all-subs '(1 2 3)) 8) ->
; '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
(define plus1
  (lambda (seq)
    (if (equal? seq empty) seq
        (if (equal? (car seq) 0)
            (cons 1 (cdr seq))
            (cons 0 (plus1 (cdr seq)))))))

(define get-seq
  (lambda (n)
    (if (equal? n 0)
        empty
        (cons 0 (get-seq (- n 1))))))

(define get-sub-by-seq
  (lambda (seq long)
    (if (= (length seq) 0)
        empty
        (if (= (car seq) 1)
            (cons (car long)
                  (get-sub-by-seq (cdr seq) (cdr long)))
            (get-sub-by-seq (cdr seq) (cdr long))))))

(define seq-is-full
  (lambda (seq)
    (if (equal? seq '()) #t
        (if (= (car seq) 0) #f
            (seq-is-full (cdr seq))))))

(define helper
  (lambda (seq long)
    (if (empty? seq)
        (cons empty (lambda () empty))
        (cons (get-sub-by-seq seq long)
              (lambda ()
                (if (seq-is-full seq)
                    empty
                    (helper (plus1 seq) long)))))))

(define all-subs
  (lambda (long)
    (helper (get-seq (length long)) long)))



;;;;;;;;;;;;;;;;;;;;;
; Part 4: The tests ;
;;;;;;;;;;;;;;;;;;;;;


(define take
  (lambda (lzl n)
    (if (equal? lzl empty-lzl)
        empty-lzl
        (if (= n 0) empty
            (cons-lzl (head lzl)
                      (take (tail lzl) (- n 1)))))))


;; Make sure to add take or another utility to test here
;; If the results are obained in a different order, change the test accordingly.
(check-inf-loop (lambda () (take (all-subs '(1 2 3)) 8)))

(check-inf-loop (lambda () (take (all-subs '()) 1)))
(check-inf-loop (lambda () (take (all-subs '(1 2 3 4 5)) 32)))
(check-inf-loop (lambda () (take (all-subs '(1 2 3 4 5 6 7)) 128)))
(check-inf-loop (lambda () (take (all-subs '(1 2 3 4 5 6 7 8)) 256)))
(check-inf-loop (lambda () (take (all-subs '()) 100)))


;; Write more tests - at least 5 tests.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Part 5: The tests expected results;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
> (check-inf-loop (lambda () (take (all-subs '(1 2 3)) 8))
'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
|#