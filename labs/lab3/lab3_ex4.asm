;=================================================
; Name: Nathan Ha
; Email: 
; 
; Lab: lab 3, ex 4
; Lab section: 
; TA: 
; 
;=================================================

; summary: reads 10 characters, stores them in array, then loops through array printing everything (but this time it ends the loop automatically)

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

AND R0, R0, x0
STR R0, R3, #0 ; Mem[R3] <- R0 ; puts a 0 at the end of the array
LD R0, NEWLINE
OUT

LEA R3, CHAR_ARRAY ; R3 <- CHAR_ARRAY
LDR R0, R3, #0 ; R0 <- Mem[R3]
OUT
FOR_STR 
    ADD R3, R3, #1 ; R3 <- R3 + 1
    LD R0, NEWLINE
    OUT
    LDR R0, R3, #0 ; R0 <- Mem[R3]
    OUT
BRp FOR_STR

HALT

; LOCAL DATA
CHAR_ARRAY .BLKW #10 ; reserve a block of memory with 10 slots
NEWLINE .FILL #10

.END