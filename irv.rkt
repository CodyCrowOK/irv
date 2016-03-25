#lang racket
;IRV ballot counter

(define candidates (list "Lenin" "Debs" "Roosevelt" "Reagan"))
(define votes
  (list
   (list 1 2 3)
   (list 2 3 1)
   (list 4)
   (list 4)
   (list 4)
   (list 1 3 2)
   (list 2 1 3)
   (list 3 1 2)
   )
  )

(define (tally-round ballots)
  ((lambda (votes) (list (count 1 votes) (count 2 votes) (count 3 votes) (count 4 votes))) (map car ballots))
  )

(define (count x xs)
  (if (null? xs)
      0
      (if (equal? x (car xs))
          (+ 1 (count x (cdr xs)))
          (count x (cdr xs))
          )
      )
  )
      