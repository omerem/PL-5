#lang racket
(require "myUtils.rkt"
         "lazy.rkt")
(require (only-in "q6.rkt"
                   all-subs))

; Credit to the creator of utils.rkt 

(define take
  (lambda (lz-lst n)
    (if (or (= n 0) (empty-lzl? lz-lst))
      empty-lzl
      (cons (head lz-lst)
            (take (tail lz-lst) (- n 1))))))

(define lzl-map
  (lambda (f lzl)
    (if (empty-lzl? lzl)
        lzl
        (cons-lzl (f (head lzl))
                  (lambda () (lzl-map f (tail lzl)))))))

(define lzl-scale
  (lambda (c lzl)
    (lzl-map (lambda (x) (* x c)) lzl)))

(define powers 
  (lambda (power)
    (cons-lzl 
      1 
      (lambda ()
        (lzl-scale
          power
          (powers power)
        )
      )
    )
  )
)

(define sum 
  (lambda (theList)
    (if (empty? theList)
      0
      (+ (car theList) (sum (cdr theList)))
    )
  )
)

(define length-value-comperator 
  (lambda (list1 list2)
    (or (< (length list1) (length list2)) (and (equal? (length list1) (length list2)) (< (sum list1) (sum list2))))
  )
)
(define listEqual? 
  (lambda (list1 list2)
    (equal? (sort list1 length-value-comperator ) (sort list2 length-value-comperator ))
  )
)

(define q1-tests
  (lambda ()
    (display "q1-tests tests:\t")
    (run-tests
     (test (check-inf-loop (lambda () (inf 5))) 
           => 'infinite)
     (test (check-inf-loop (lambda () (take1 (lzl-collatz 563) identity)))
           => '(563 1690 845 2536 1268 634 317 952 476 238 119 358 179 538 269 
              808 404 202 101 304 152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 
              40 20 10 5 16 8 4 2 1))
      (test (check-inf-loop (lambda () (take1 (lzl-collatz 563) (lambda (x) (> x 1)))))
           => '(563 1690 845 2536 1268 634 317 952 476 238 119 358 179 538 269 808 404 
              202 101 304 152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 
              4 2))
      (test (check-inf-loop (lambda () (take1 (lzl-collatz 563) (lambda (x) (not (= x 1))))))
           => '(563 1690 845 2536 1268 634 317 952 476 238 119 358 179 538 269 808 404 202 101 
              304 152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2))
      (test (check-inf-loop (lambda () (take1 (collatz 563) identity))) 
           => 'infinite)
      (test (check-inf-loop (lambda () (take1 (collatz 563) (lambda (x) (= x 1)))))
           => '())
      (test (check-inf-loop (lambda () (take1 (collatz 563) (lambda (x) (not (= x 1))))))
           => '(563 1690 845 2536 1268 634 317 952 476 238 119 358 179 538 269 808 404 202 
               101 304 152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2))
      (test (check-inf-loop (lambda () (take1 (collatz 563) (lambda (x) (> x 100)))))
           => '(563 1690 845 2536 1268 634 317 952 476 238 119 358 179 538 269 808 404 202 101 304 152))
      (test (check-inf-loop (lambda () (take1 (collatz 563) (lambda (x) (< x 1)))))
                => '())
       (test (check-inf-loop (lambda () (take1 (collatz 563) (lambda (x) (> x 0)))))
                => 'infinite)
      (test (take (powers 2) 10)
                => '(1 2 4 8 16 32 64 128 256 512))
      (test  (take1 (powers 2) (lambda (x) (< x 100)))
                => '(1 2 4 8 16 32 64))
      (test  (take1 (powers 2) (lambda (x) (< x 64)))
                      => '(1 2 4 8 16 32))  
      (test  (take1 (powers 2) (lambda (x) (= x 128)))
                      => '()) 
)))

(define q6-tests
  (lambda ()
    (display "q6-tests tests:\t")
    (run-tests
     (test  (listEqual? (take (all-subs '(1 2 3)) 100) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
           => #t)
     (test  (listEqual? (take (all-subs '(1 2)) 100) '(() (2) (1) (1 2)))
      => #t)
      (test  (listEqual? (take (all-subs '(1)) 100) '(() (1)))
      => #t)
      (test  (listEqual? (take (all-subs '()) 100) '(()))
      => #t)
      (test  (listEqual? (take (all-subs '(1 2 3 4)) 100) '( (1 2 4) () (1) (1 2) (2) (3) (1 2 3 4) (1 2 3) (1 4) (2 3) (2 4) (3 4)  (1 3 4) (1 3) (2 3 4) (4)))
      => #t)
)))

; Invoke
(q1-tests)
(q6-tests)