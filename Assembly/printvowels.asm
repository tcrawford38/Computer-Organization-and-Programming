;;=============================================================
;;CS 2110 - Spring 2020
;;Homework 5 - Print the Vowels in a String
;;=============================================================
;;Name: Thomas Crawford
;;=============================================================
;;Pseudocode (see PDF for explanation)
;;string = "TWENTY ONE TEN";
;;i = 0;
;;while(string[i] != ’\0’){
;;  if(string[i] == ’A’ || string[i] == ’E’ ||
;;  string[i] == ’I’ || string[i] == ’O’ ||
;;  string[i] == ’U’){
;;      print(string[i]);
;;  }
;;i++;
;;}
.orig x3000
LD R0, STRING ;; R0 = STRING
AND R1, R1, #0  ;; Clears R1
LD R2, A ;; R2 = A
LD R3, E ;; R3 = E
LD R4, I ;; R4 = I
LD R5, O ;; R5 = O
LD R6, U ;; R6 = U
W1 ;; Beginning of while loop
AND R7, R7, 0 ;; Clear R7
ADD R7, R0, R1 ;; String address (x4000) plus i for character address
LDR R7, R7, #0 ;; Run the character address back into memory for the character ASCII
BRz ENDW1 ;; Branch to end of while loop if ASCII character is a null terminator
NOT R2, R2 ;; Flip the bits
ADD R2, R2, #1 ;; Add 1 (-A)
ADD R2, R7, R2 ;; string[I] - A
BRz THEN ;; branch to then statement
NOT R3, R3 ;; Flip the bits
ADD R3, R3, #1 ;; Add 1 (-E)
ADD R3, R7, R3 ;; string[I] - E
BRz THEN ;; branch to then statement if ASCII characters are the same
NOT R4, R4 ;; Flip the bits
ADD R4, R4, #1 ;; Add 1 (-I)
ADD R4, R7, R4 ;; string[I] - I
BRz THEN ;; branch to then statement if ASCII characters are the same
NOT R5, R5 ;; Flip the bits
ADD R5, R5, #1 ;; Add 1 (-O)
ADD R5, R7, R5 ;; string[I] - O
BRz THEN ;; branch to then statement if ASCII characters are the same
NOT R6, R6 ;; Flip the bits
ADD R6, R6, #1 ;; Add 1 (-U)
ADD R6, R7, R6 ;; string[I] - U
BRz THEN ;; branch to then statement if ASCII characters are the same
BRnzp ENDIF ;; branch to ENDIF if ASCII characters are not vowels
THEN ;; Then statement
AND R0, R0, #0 ;; Clear R0
ADD R0, R0, R7 ;; Put R7's ASCII character into R0 for trap OUT
TRAP x21 ;; Outputs ASCII character
ENDIF ADD R1, R1, #1 ;; Increment R1 counter
LD R0, STRING ;; Reset R0
LD R2, A ;; Reset R2
LD R3, E ;; Reset R3
LD R4, I ;; Reset R4
LD R5, O ;; Reset R5
LD R6, U ;; Reset R6
BRnzp W1 ;; branch back to W1 for loop
ENDW1 ;; End of while loop

HALT

A .fill x41    ;; A in ASII
E .fill x45 ;; E in ASCII
I .fill x49 ;; I in ASCII
O .fill x4f ;; O in ASCII
U .fill x55 ;; U in ASCII

STRING .fill x4000
.end

.orig x4000
.stringz "TWENTY ONE TEN"
.end
