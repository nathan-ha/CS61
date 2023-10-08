;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
    LDI R1, SOMETHING_ADDRESS ; loads value (should be #21) at the address into R1
    LD R2, DEC_11 ; stores #11 into R2
    STI R2, SOMETHING_ADDRESS ; overwrites value at address with R2's value
    LDI R3, SOMETHING_ADDRESS ; loads the value in the address (should be 11) into R3
HALT
SOMETHING_ADDRESS .FILL x4000
DEC_11 .FILL #11
.END

.ORIG x4000
    SOMETHING .FILL #21 ; store #21 at x4000
.END
