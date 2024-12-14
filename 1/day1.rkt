#lang racket

(define (get-puzzle-lines path)
  (with-input-from-file path
    (λ ()
      (for/list ([line (in-lines)])
        (map string->number (string-split line #:repeat? #t))))))

(define (solve-part-1 left-list right-list)
  (for/sum ([left-element left-list]
            [right-element right-list])
    (abs (- left-element right-element))))

(define (solve-part-2 left-list right-list)
  (let ([similarity-scores (map
                            (λ (left-element)
                              (count
                               (λ (right-element) (= left-element right-element))
                               right-list))
                            left-list)])
    (for/sum ([left-element left-list]
              [similarity similarity-scores])
      (* left-element similarity))))
  

(define puzzle-lines (get-puzzle-lines "day1.txt"))
(define left-list  (sort (map car puzzle-lines) <))
(define right-list (sort (map cadr puzzle-lines) <))
    
(solve-part-1 left-list right-list)
(solve-part-2 left-list right-list)