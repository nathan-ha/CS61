;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 2, ex 3
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
    LD R0, HEX_4000
    LDR R1, R0, #0 ; loads value at address in R0 into R1
    STR R1, R0, #1 ; stores value at address held by R1 into (address held by R0) + 1
    LDI R2, HEX_4001 ; loads into R2 value at x4001 (should be 11)
HALT
    THING_ADDRESS .FILL x4000
    HEX_4000 .FILL x4000
    HEX_4001 .FILL x4001
.END

.ORIG x4000
    THING .FILL #11
.END