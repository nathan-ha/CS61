;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
    ; goal: access several addresses with one pointer
    LD R0, DATA_PRT
    LDR R1, R0, #0 ; R1 <- R0
    LDR R2, R0, #1 ; R2 <- Mem[R1+1]
    
    ADD R1, R1, #1 ; R1 <- R1 + 1
    ADD R2, R2, #1 ; R2 <- R2 + 1
    
    STR R1, R0, #0 ; Mem[R0] <- R1
    STR R1, R0, #1 ; Mem[R0+1] <- R2
HALT
    DATA_PRT .FILL x4000
.END

.ORIG x4000
    DEC_11 .FILL #11
    DEC_22 .FILL #22
.END