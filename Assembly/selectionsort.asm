;;=============================================================
;;CS 2110 - Spring 2020
;;Homework 5 - Selection Sort
;;=============================================================
;;Name: Thomas Crawford
;;=============================================================
;;Pseudocode (see PDF for explanation)
;;x = 0;                         // current swapping index in the array
;;len = length of array;
;;while(x < len - 1) {
;;  z = x;                     // index of minimum value in unsorted portion of array
;;  y = x + 1;                 // current index in array
;;  while (y < len) {
;;      if (arr[y] < arr[z]) {
;;          z = y;             // update the index of the minimum value
;;      }
;;      y++;
;;  }
;;  if (z != x) {
;;      temp = arr[x];         // perform a swap
;;      arr[x] = arr[z];
;;      arr[z] = temp;
;;  }
;;      x++;
;;}
;; R0 = x, R1 = len, R2 = Conditions and ops, R3 = z, R4 = y, R5 = Array ops
;; R6 = Array ops, R7 = Array ops
.orig x3000
AND R0, R0, #0 ;; R0 = x = 0
AND R1, R1, #0 ;; Clears R1
LD R1, LENGTH ;; R1 = len = LENGTH
AND R2, R2, #0 ;; Clears R2
W1 NOT R2, R1 ;; x - len (part 1)
ADD R2, R2, #1 ;; x - len (part 2)
ADD R2, R0, R2 ;; x - len (part 3)
ADD R2, R2, #1 ;; while (x - len + 1 < 0)
BRzp ENDW1 ;; Branch to end of while loop if greater than or equal to x - len + 1 < 0
AND R3, R3, #0 ;; Clear R3
ADD R3, R3, R0 ;; R3 = z = x
AND R4, R4, #0 ;; Clears R4
ADD R4, R4, R0 ;; x
ADD R4, R4, #1 ;; R4 = y = x + 1
AND R2, R2, #0 ;; Clears R2
W2 NOT R2, R1 ;; y - len (part 1) also beginning of inner while loop
ADD R2, R2, #1 ;; y - len (part 2)
ADD R2, R4, R2 ;; while (y - len < 0)
BRzp ENDW2 ;; Branch to end of while loop if greater than or equal to y - len < 0
LD R5, ARRAY ;; R5 = Array
AND R2, R2, #0 ;; Clear R2
ADD R2, R4, R5 ;; Array + y = y address for Array
LDR R5, R2, #0 ;; arr[y]
LD R6, ARRAY ;; R6 = Array
AND R2, R2, #0 ;; Clear R2
ADD R2, R3, R6 ;; Array + z = z address for Array
LDR R6, R2, #0 ;; arr[z]
AND R2, R2, #0 ;; Clear R2
NOT R2, R6 ;; arr[y] - arr[z] (part 1)
ADD R2, R2, #1 ;; arr[y] - arr[z] (part 2)
ADD R2, R5, R2 ;; if (arr[y] - arr[z]) < 0
BRzp ENDIF1 ;; Branch to end of if statement
AND R3, R3, #0 ;; Clear R3
ADD R3, R4, #0 ;; z = y
ENDIF1 ADD R4, R4, #1 ;; y++
BRnzp W2 ;; Branch to beginning of while loop
ENDW2 ;; End of inner while loop
AND R2, R2, #0 ;; Clear R2
NOT R2, R0 ;; z - x (part 1)
ADD R2, R2, #1 ;; z - x (part 2)
ADD R2, R3, R2 ;; if (z - x) != 0
BRz ENDIF2 ;; Branch to end of if statement if z and x are equal
LD R5, ARRAY ;; R5 = Array
AND R2, R2, #0 ;; Clear R2
ADD R2, R0, R5 ;; x + Array = x address for Array. R2 contains x address.
LDR R5, R2, #0 ;; Get address from R2, go to memory, and put that data in R5 (temp)
LD R6, ARRAY ;; R6 = Array
AND R7, R7, #0 ;; Clear R7
ADD R7, R3, R6 ;; R3 (z) + R6(Array address) = z address into R7
LDR R6, R7, #0 ;; Get address from R7, go to memory, and put that data into R6
STR R6, R2, #0 ;; Get arr[z] from R6, and put that data into arr[x] from R2
STR R5, R7, #0 ;; Get temp from R5, and put that data into arr[z] from R7
ENDIF2 ;; End of if statement 2
ADD R0, R0, #1 ;; Increment x, x++
BRnzp W1 ;; Branch back to the beginning of the loop
ENDW1 ;; End of While statement 1

HALT

ARRAY .fill x4000
LENGTH .fill 7
.end

.orig x4000
.fill 4
.fill 9
.fill 0
.fill 2
.fill 9
.fill 3
.fill 10
.end
