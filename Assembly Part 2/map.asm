;;=======================================
;; CS 2110 - Spring 2019
;; HW6 - Map Function to Array
;;=======================================
;; Name:
;;=======================================

;; In this file, you must implement the 'map' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'map' label.


.orig x3000
HALT

map
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of map: Array A, int len, function func
;; Array A is a number representing the address of the first element in the array. If the array starts at x4000, then A will be the number x4000.
;; int len is the length of the array. Recall that arrays are not null-terminated like strings, so you must use the length to know when to stop modifying the array.
;; function func is the address of the function you should call. What function can you use to jump to a subroutine at this address?
;;
;; Psuedocode:
;; map(Array A, int len, function func) {
;;     for(i = 0; i < len; i++) {
;;         A[i] = func(A[i]);
;;     }
;;     return A;
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
LDR R0, R5, #4 ;; Load A address into R0
LDR R2, R5, #6 ;; Load func into R2
AND R3, R3, #0 ;; Clear R3 for i
LOOP ;; Beginning of for loop
LDR R1, R5, #5 ;; Load len into R1
NOT R4, R1 ;; i - len
ADD R4, R4, #1 ;; ^
ADD R4, R3, R4 ;; i - len into R4
BRzp ENDLOOP ;; Branch to end of loop if i-len is not negative
ADD R4, R0, R3 ;; A + i for address into R4
LDR R1, R4, #0 ;; Load A[I] into R1
ADD R6, R6, #-1 ;; Push one spot on stack
STR R1, R6, #0 ;; Push A[I] on stack
JSRR R2 ;; Jump to func
LDR R1, R6, #0 ;; Load func(A[I]) into R1
ADD R6, R6, #2 ;; Pop two spots on stack
STR R1, R4, #0 ;; Store the data at R1 into the address at R4
ADD R3, R3, #1 ;; i++
BRnzp LOOP ;; Loop back to the beginning
ENDLOOP ;; End of loop
BRnzp TEAR
TEAR
STR R0, R5, #3 ;; Store A in RV
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

; Needed by Simulate Subroutine Call in complx
STACK .fill xF000
.end

;; The following block gives an example of what the passed-in array may look like.
;; Note that this will not necessarily be the location of the array in every test case.
;; The 'A' parameter will be the address of the first element in the array (for example, x4000).
.orig x4000
    .fill 6
	.fill 2
	.fill 5
	.fill 8
	.fill 3
.end

;; The following functions are possible functions that may be called by the map function.
;; Note that these functions do not do the full calling convention on the callee's side.
;; However, they will work perfectly fine as long as you follow the convention on the caller's side.
;; Do not edit these functions; they will be used by the autograder.
.orig x5000	;; double
	ADD R6, R6, -2
	STR R0, R6, 0
	LDR R0, R6, 2
	ADD R0, R0, R0
	STR R0, R6, 1
	LDR R0, R6, 0
	ADD R6, R6, 1
	RET
.end
.orig x5100 ;; negate
	ADD R6, R6, -2
	STR R0, R6, 0
	LDR R0, R6, 2
	NOT R0, R0
	ADD R0, R0, 1
	STR R0, R6, 1
	LDR R0, R6, 0
	ADD R6, R6, 1
	RET
.end
.orig x5200 ;; increment
	ADD R6, R6, -2
	STR R0, R6, 0
	LDR R0, R6, 2
	ADD R0, R0, 1
	STR R0, R6, 1
	LDR R0, R6, 0
	ADD R6, R6, 1
	RET
.end
.orig x5300 ;; isOdd
	ADD R6, R6, -2
	STR R0, R6, 0
	LDR R0, R6, 2
	AND R0, R0, 1
	STR R0, R6, 1
    LDR R0, R6, 0
	ADD R6, R6, 1
	RET
.end
.orig x5400 ;; decrement
	ADD R6, R6, -2
	STR R0, R6, 0
	LDR R0, R6, 2
	ADD R0, R0, -1
	STR R0, R6, 1
	LDR R0, R6, 0
	ADD R6, R6, 1
	RET
.end
