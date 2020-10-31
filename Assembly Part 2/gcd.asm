;;=======================================
;; CS 2110 - Spring 2019
;; HW6 - Recursive Greatest Common Denominator
;;=======================================
;; Name:Thomas Crawford
;;=======================================

;; In this file, you must implement the 'gcd' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'gcd' label.


.orig x3000
HALT

gcd
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of GCD: integer a, integer b
;;
;; Psuedocode:
;; gcd(int a, int b) {
;;     if (a == b) {
;;         return a;
;;     } else if (a < b) {
;;         return gcd(b, a);
;;     } else {
;;         return gcd(a - b, b);
;;     }
;; }

ADD R6, R6, #-4 ;; push 4 spots
STR R7, R6, #2 ;; Save return address
STR R5, R6, #1 ;; Save Old FP
ADD R5, R6, #0 ;; Copy new FP to SP
ADD R6, R6, #-5 ;; push 5 spots for registers
STR R0, R5, #-1 ;; Save RO
STR R1, R5, #-2 ;; Save R1
STR R2, R5, #-3 ;; Save R2
STR R3, R5, #-4 ;; Save R3
STR R4, R5, #-5 ;; Save R4
LDR R0, R5, #4 ;; Load a into R0
LDR R1, R5, #5 ;; Load b into R1
NOT R2, R1 ;; a - b
ADD R2, R2, #1 ;; ^
ADD R2, R0, R2 ;; a - b into R2
BRnp ELSEIF ;; Branch to ELSEIF if a != b
BRnzp TEAR ;; Branch to the tear down
ELSEIF ;; ELSEIF statement
ADD R2, R2, #0 ;; Set condition codes for a - b
BRzp ELSE ;; Branch to ELSE statement if a >= b
ADD R6, R6, #-2 ;; Push two spots on stack
STR R1, R6, #0 ;; Push b on stack
STR R0, R6, #1 ;; Push a on stack
JSR gcd ;; Recursion
LDR R0, R6, #0 ;; Load gcd(b, a) into R0
ADD R6, R6, #3 ;; Pop three spots on stack
BRnzp TEAR ;; Branch to the tear down
ELSE ;; Else statement
ADD R6, R6, #-2 ;; Push two spots on stack
STR R2, R6, #0 ;; Push a - b on stack
STR R1, R6, #1 ;; Push b on stack
JSR gcd ;; Recursion
LDR R0, R6, #0 ;; Load gcd(a - b, b) into R0
ADD R6, R6, #3 ;; Pop three spots on stack
BRnzp TEAR ;; Branch to the tear down
TEAR
STR R0, R5, #3 ;; Store result (from R0) in RV
LDR R0, R5, #-1 ;; Restore RO
LDR R1, R5, #-2 ;; Restore R1
LDR R2, R5, #-3 ;; Restore R2
LDR R3, R5, #-4 ;; Restore R3
LDR R4, R5, #-5 ;; Restore R4
ADD R6, R5, #0 ;; Copy SP to FP
LDR R5, R6, #1 ;; Load Old FP
LDR R7, R6, #2 ;; Load return address
ADD R6, R6, #3 ;; Pop everything except for return value
RET ;; Return result

; Needed by Simulate Subroutine Call in complx
STACK .fill xF000
.end
