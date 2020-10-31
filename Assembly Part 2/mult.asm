;;=======================================
;; CS 2110 - Spring 2019
;; HW6 - Recursive Multiplication
;;=======================================
;; Name:Thomas Crawford
;;=======================================

;; In this file, you must implement the 'mult' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'mult' label.


.orig x3000
HALT

mult
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of mult: integer a, integer b
;;
;; Psuedocode:
;; mult(int a, int b) {
;;     if (a == 0 || b == 0) {
;;         return 0;
;;     }
;;	
;;     // Since one number might be negative, we will only decrement the larger number.
;;     // This ensures that one parameter will eventually become zero.
;;     if (a > b) {
;;         var result = b + mult(a - 1, b);
;;         return result;
;;     } else {
;;         var result = a + mult(a, b - 1);
;;         return result;
;;     }
;; }


;; IMPORTANT NOTE: we recommend following the pseudocode exactly. Part of the autograder checks that your implementation is recursive.
;; This means that your implementation might fail this test if, when calculating mult(6,4), you recursively calculated mult(6,3) instead of mult(5,4).
;; In particular, make sure that if a == b, you calculate mult(a,b-1) and not mult(a-1,b), as the psuedocode says.
;; If you fail a test that expects you to calculate mult(5,4) and you instead calculated mult(4,5), try switching the arguments around when recursively calling mult.


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
BRz THEN ;; If a = 0, then branch to then statement
LDR R1, R5, #5 ;; Load b into R1
BRz THEN ;; If b = 0, then branch to then statement
NOT R2, R1 ;; a - b
ADD R2, R2, #1 ;; ^
ADD R2, R0, R2 ;; ^
BRnz IFELSE1 ;; Branch to else statement if less than or equal to
ADD R6, R6, #-2 ;; Push two spots on stack
ADD R0, R0, #-1 ;; a - 1
STR R0, R6, #0 ;; Push a - 1 on stack
LDR R1, R5, #5 ;; Load b into R1
STR R1, R6, #1 ;; Push b on stack
JSR mult ;; Recursion
LDR R0, R6, #0 ;; Load mult(a-1, b) into R0
ADD R6, R6, #3 ;; Pop three spots on stack
LDR R1, R5, #5 ;; Load b into R1
ADD R0, R0, R1 ;; Add b + mult(a - 1, b)
STR R0, R5, #0 ;; Load result in LV1
BRnzp TEAR ;; Branch to the tear down
IFELSE1 ;; Else statement
ADD R6, R6, #-2 ;; Push two spots on stack
LDR R1, R5, #5 ;; Load b into R1
ADD R1, R1, #-1 ;; b - 1
STR R0, R6, #0 ;; Push a on stack
STR R1, R6, #1 ;; Push b - 1 on stack
JSR mult ;; Recursion
LDR R0, R6, #0 ;; Load mult(a, b - 1) into R0
ADD R6, R6, #3 ;; Pop three spots on stack
LDR R1, R5, #4 ;; Load a into R1
ADD R0, R0, R1 ;; ADD a + mult(a, b - 1)
STR R0, R5, #0 ;; Load result in LV1
BRnzp TEAR ;; Branch to the tear down
THEN ;; Then statement
AND R0, R0, #0 ;; Clear R0
BRnzp TEAR ;; Branch to the tear down
TEAR
STR R0, R5, #3 ;; Store result in RV
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


;; Needed by Simulate Subroutine Call in complx

STACK .fill xF000


.end
