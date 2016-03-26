#lang racket

(require srfi/1)  ; import `list-index`
(require srfi/26) ; import `cute`

; IRV ballot counter

; Testing data
(define candidates (list "Lenin" "Debs" "Roosevelt" "Reagan"))
(define votes
  (list
   (list 1 2 3)
   (list 2 3 1)
   (list 4)
   (list 4)
   (list 4)
   (list 4 3 2)
   (list 4 1 3)
   (list 3 1 2)))

; Main function
(define (count-votes ballots)
  (+ 1 0))

; Tallies each round
(define (tally-round ballots)
  ((lambda (votes) (list (count 1 votes) (count 2 votes) (count 3 votes) (count 4 votes))) (map car ballots)))

; Count the occurrences of x in xs
(define (count x xs)
  (if (null? xs)
      0
      (if (equal? x (car xs))
          (+ 1 (count x (cdr xs)))
          (count x (cdr xs)))))

; Sums the values in xs, assumes xs is wholly numbers
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

; Checks if there is a winner in a given round of tallying
(define (winner-exists xs)
  (winner-exists-inner xs (sum xs)))

; Helper function for winner-exists
(define (winner-exists-inner xs sum)
  (if (null? xs)
      false
      (if (is-winner (car xs) sum)
          (is-winner (car xs) sum)
          (winner-exists-inner (cdr xs) sum))))

; Checks if x is over 50% of sum
(define (is-winner x sum)
  (> x (/ sum 2)))

; Find position of the lowest element in a list
(define (min-position list)
  (and (not (null? list))
       (list-index (cute = (apply min list) <>) list)))