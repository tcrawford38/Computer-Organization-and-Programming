;;=============================================================
;;CS 2110 - Spring 2020
;;Homework 5 - Iterative Multiplication
;;=============================================================
;;Name:Thomas Crawford
;;=============================================================
;;Pseudocode (see PDF for explanation)
;;a = (argument 1);
;;b = (argument 2);
;;ANSWER = 0;
;;while (b > 0) {
;;  ANSWER = ANSWER + a;
;;  b--;
;; }
;; note: when the while-loop ends, the value stored at ANSWER is a times b.

.orig x3000
LD R0, A ;; R0 = A = 5
LD R1, B ;; R1 = B = 15
AND R2, R2, #0 ;; R2 = ANSWER = 0
W1 ADD R1, R1, #0 ;; while (b > 0)
BRnz ENDW1 ;; Branch to end of while loop if less than or equal to b
ADD R2, R2, R0 ;; ANSWER = ANSWER + a
ADD R1, R1, #-1 ;; b--
BRnzp W1 ;; Branch to beginning of while loop
ENDW1 ;; End of while loop
ST R2, ANSWER ;; Store R2 (a times b) into Answer

HALT

A   .fill 5
B   .fill 15

ANSWER .blkw 1

.end
