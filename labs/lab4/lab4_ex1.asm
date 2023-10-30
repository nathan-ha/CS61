;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 4, ex 1
; Lab section: 
; TA: 
; 
;=================================================
; goal: create subroutine and test harness
.ORIG x3000
    LD R1, DATA_PTR
    LD R2, SUB_PTR
    JSRR R2
HALT

; LOCAL_DATA
DATA_PTR .FILL x4000
SUB_PTR .FILL x3200

.END

SUB_FILL_ARRAY
;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY
; Description: fills up an array starting at an address in R1 with the numbers (not chars) 0 through 9
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200
    AND R2, R2, x0 ; R2 <- 0 ; numbers to be stored
    LD R3, DEC_10 ; R3 <- 9 ; counter
    FOR_10
        STR R2, R1, #0 ; Mem[R1] <- R2
        ADD R2, R2, #1
        ADD R1, R1, #1 ; moves to next memory slot
        ADD R3, R3, #-1
    BRp FOR_10
RET

; LOCAL DATA
DEC_10 .FILL #10

.END

.ORIG x4000
COOL_ARRAY .BLKW #10
.END