#lang racket

(require srfi/1)  ; `list-index`
(require srfi/26) ; `cute`
(require 2htdp/batch-io) ; `read-csv-file`

; IRV ballot counter

; Main function
(define (read-votes-file filename)
  (find-winner (get-votes filename) (get-candidates filename)))

; Gets the candidates, which should be the first line of the csv
(define (get-candidates filename)
  (car (read-csv-file filename)))

; Gets the ballots from csv and converts them to usable form
(define (get-votes filename)
  (map (lambda (xs) (map string->number xs)) (cdr (read-csv-file filename))))

; Return election winner
(define (find-winner ballots candidates)
  (get-element (count-votes ballots) candidates))

; Get nth element from xs
(define (get-element n xs)
  (if (zero? n)
      (car xs)
      (get-element (- n 1) (cdr xs))))

; Move through the rounds until a winner is found
(define (count-votes ballots)
  (if (winner-exists (tally-round ballots))
      (max-position (tally-round ballots))
      (count-votes (remove-loser ballots))))

(define (remove-loser ballots)
  (map remove-head-if-loser ballots `((min-position (tally-round ballots)))))

(define (remove-head-if-loser ballot loser)
  (if (equal? loser (car ballot))
      (cdr ballot)
      ballot))

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

; Find position of the smallest element in a list
(define (min-position list)
  (and (not (null? list))
       (list-index (cute = (apply min list) <>) list)))

; Find position of the largest element in a list
(define (max-position list)
  (and (not (null? list))
       (list-index (cute = (apply max list) <>) list)))
