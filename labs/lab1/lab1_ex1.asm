;=================================================
; Name: Nathan Ha
; Email:  nha023@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000

; INSTRUCTIONS
    LD R1, DEC_0 ; R1 <- #0
    LD R2, DEC_12 ; R2 <- #12
    LD R3, DEC_6 ; R3 <- #6
    
    DO_WHILE_LOOP
        ADD R1, R1, R2 ; R1 <- R1 + R2
        ADD R3, R3, #-1 ; R3 <- R3 - #1 
        BRp DO_WHILE_LOOP ; if R3 is positive, go to DO_WHILE_LOOP
    END_DO_WHILE_LOOP
    
    HALT ; end of program
    
; LOCAL DATA
    DEC_0 .FILL #0 ; store #0 into labeled address
    DEC_12 .FILL #12
    DEC_6 .FILL #6
    
.END
    