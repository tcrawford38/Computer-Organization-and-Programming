;; =============================================================
;; CS 2110 - Spring 2020
;; HW6 - Replace Values in Linked List
;; =============================================================
;; Name:Thomas Crawford
;; ============================================================

;; In this file, you must implement the 'mult' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'replaceValueLL' label.

.orig x3000
HALT

replaceValueLL
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of replaceValueLL: Node head, int r 
;;
;; Psuedocode:
;; replaceValueLL(Node head, int r) {
;;     if (head == null) {
;;         return head;
;;     }
;;     if (head.data == r) {
;;         head.data = 0;
;;     } else {
;;         head.data = head.data * r;
;;     }
;;     replaceValueLL(head.next, r);
;;     return head;
;; }

;; NOTE: if you need to calculate head.data * r using the mult subroutine, please make head.data be the first parameter and r be the second parameter.
;; The autograder will check if you are calling mult at appropriate times.
;; If the autograder fails you for not calling mult even though you did, try switching the arguments around.


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
LDR R0, R5, #4 ;; Load Node address into R0
LDR R1, R5, #5 ;; Load r address into R1
ADD R0, R0, #0 ;; Set condition codes
BRnp ELSE1 ;; Branch to else statement if node is not null
Brnzp TEAR ;; Branch to tear down for returning node
ELSE1 ;; Else statement
LDR R2, R0, #1 ;; Load Node data into R2
AND R3, R3, #0 ;; Clear R3
NOT R3, R1 ;; data - r
ADD R3, R3, #1 ;; ^ 
ADD R3, R2, R3 ;; ^
BRnp ELSE2 ;; Branch to inner else statement if data - r is not zero
AND R3, R3, #0 ;; Clear R3
STR R3, R0, #1 ;; Store 0 at the Node's data address
BRnzp OUTER ;; Branch to outside the if statement
ELSE2 ;; Inner else statement
ADD R6, R6, #-2 ;; Push two spots on stack
STR R2, R6, #0 ;; Push Node data to stack
STR R1, R6, #1 ;; Push r to stack
JSR mult ;; Jump to mult subroutine
LDR R3, R6, #0 ;; Load mult(head.data, r) into R3
ADD R6, R6, #3 ;; Pop three spots on stack
STR R3, R0, #1 ;; Store R3 at the Node's data address
OUTER ;; Outside the if statement
ADD R6, R6, #-2 ;; Push two spots on stack
LDR R3, R0, #0 ;; Load Node next address in R3
STR R3, R6, #0 ;; Push next address on stack
STR R1, R6, #1 ;; Push r to stack
JSR replaceValueLL ;; Jump to replaceValueLL subroutine
ADD R6, R6, #3 ;; Pop three spots on stack
BRnzp TEAR
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
RET ;; Return

STACK .fill xF000

;; This is a mult subroutine that you can call to multiply numbers.
;; Note that this is not the same as the one you need to implement for Part 1 of this homework;
;; the one you implement there needs to be recursive, and must support negative numbers.
;; However, you can use this subroutine for this homework question.
;; Note that this subroutine does not follow the full calling convention; however, it will work fine if you properly follow the convention on the caller's side.
mult
;; Arguments: int a, int b
ADD R6, R6, -4
STR R0, R6, 0
STR R1, R6, 1
STR R2, R6, 2
AND R0, R0, 0
LDR R1, R6, 4
LDR R2, R6, 5
BRz 3
ADD R0, R0, R1
ADD R2, R2, -1
BRp -3
STR R0, R6, 3
LDR R0, R6, 0
LDR R1, R6, 1
LDR R2, R6, 2
ADD R6, R6, 3
RET
.end


;; The following is an example of a small linked list that starts at x4000.
;; The first number (offset 0) contains the address of the next node in the linked list, or zero if this is the final node.
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill 0
.fill 12
.end
