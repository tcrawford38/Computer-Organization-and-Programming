;;=============================================================
;;CS 2110 - Spring 2020
;;Homework 5 - Make elements of a Linked List into a string
;;=============================================================
;;Name:
;;=============================================================
;;Pseudocode (see PDF for explanation)
;;length = LL.length;
;;curr = LL.head; //HINT: What can an LDI instruction be used for?
;;ANSWER = char[length]; //This character array will already be setup for you
;;i = 0;
;;while (curr != null) {
;;  ANSWER[i] = curr.value;
;;  curr = curr.next;
;;  i++;
;;}
;; R0 = length, R1 = curr, R2 = Answer, R3 = i, R4 = Answer[i], R5 = curr.value
.orig x3000
LD R0, LL ;; Load LL into R0
LDR R0, R0, #1 ;; Load LL.length into R0
LDI R1, LL ;; Load LL.head to R1
LD R2, ANSWER ;; Load ANSWER into R2
AND R3, R3, #0 ;; Clear R3 to 0
W1 ADD R1, R1, #0 ;; Add curr to 0 to set condition codes for curr
BRz ENDW1 ;; Branches to end of loop if curr is zero or null
AND R4, R4, #0 ;; Clears R4
ADD R4, R2, R3 ;; Answer + i = Answer[i]
LDR R5, R1, #1 ;; Go into LL.head, and add 1 in order to get the curr.value data
STR R5, R4, #0 ;; Store curr.value into the address of Answer[i]
LDR R1, R1, #0 ;; Take curr address, go to memory, and use that address for curr
ADD R3, R3, #1 ;; Increment i
BRnzp W1 ;; Branch to beginning of loop
ENDW1 ;; End of while loop
ADD R4, R2, R3 ;; Address for null terminating character
AND R6, R6, #0 ;; Clear R6
STR R6, R4, #0 ;; Store the data 0 at the null terminating character address

HALT

LL .fill x6000
ANSWER .fill x5000
.end

.orig x4000
.fill x4008
.fill 98
.fill x400A
.fill 73
.fill x4002
.fill 103
.fill x0000 
.fill 114
.fill x4004
.fill 97
.fill x4006
.fill 116
.end

.orig x5000
.blkw 7
.end

.orig x6000
.fill x4000
.fill 6
.end
