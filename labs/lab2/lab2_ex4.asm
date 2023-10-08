;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
    LD R1, DEC_26 ; R0 <- #26
    LD R0, DEC_64 ; R1 <- #64
    LOOP
        ADD R0, R0, #1 ; R1 <- R1 + 1
        OUT ; note: OUT only works with R0
        ADD R1, R1, #-1 ; R0 <- R0 - 1
        
    Brp LOOP
HALT
    DEC_64 .FILL #64
    DEC_26 .FILL #26
.END