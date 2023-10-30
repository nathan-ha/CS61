;=================================================
; Name: Nathan Ha
; Email: 
; 
; Lab: lab 3, ex 3
; Lab section: 
; TA: 
; 
;=================================================

; summary: reads 10 characters, stores them in array, then loops through array printing everything
; i guess i accidentally did ex 3 in ex 2 too

.ORIG x3000

AND R1, R1, x0 ; R1 <- 0
ADD R1, R1, #10 ; R1 <- 10 ; loop counter
LEA R3, CHAR_ARRAY ; R3 <- CHAR_ARRAY ; array starting point

FOR_10_READ
    GETC
    OUT
    STR R0, R3, #0 ; Mem[R3] <- R0
    ADD R3, R3, #1 ; R3 <- R3 + 1
ADD R1, R1, #-1 ; R1 <- R1 - 1
BRp FOR_10_READ

LD R0, newline
OUT

; same thing but prints out entire array
AND R1, R1, x0 ; R1 <- 0
ADD R1, R1, #10 ; R1 <- 10 ; loop counter
LEA R3, CHAR_ARRAY ; R3 <- CHAR_ARRAY

FOR_10_PRINT
    LDR R0, R3, #0 ; R0 <- Mem[R3]
    OUT
    ADD R3, R3, #1 ; R3 <- R3 + 1
    LD R0, newline
    OUT
ADD R1, R1, #-1 ; R1 <- R1 - 1
BRp FOR_10_PRINT

HALT

; LOCAL DATA
CHAR_ARRAY .BLKW #10 ; reserve a block of memory with 10 slots
newline .FILL #10

.END