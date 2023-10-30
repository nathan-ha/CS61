;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 
; TA: 
; 
;=================================================
; call subroutine in subroutine
.ORIG x3000
    LD R1, DATA_PTR
    LD R2, SUB_FILL_ARRAY
    JSRR R2
    LD R2, SUB_CONVERT_ARRAY
    JSRR R2
    LD R2, SUB_PRINT_ARRAY
    JSRR R2
    LD R2, SUB_PRETTY_PRINT_ARRAY
    JSRR R2
HALT

; LOCAL_DATA
DATA_PTR .FILL x4000
SUB_FILL_ARRAY .FILL x3200
SUB_CONVERT_ARRAY .FILL x3400
SUB_PRINT_ARRAY .FILL x3600
SUB_PRETTY_PRINT_ARRAY .FILL x3800


.END

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
    ADD R4, R1, x0 ; R4 <- R1
    FOR_10_FILL
        STR R2, R4, #0 ; Mem[R4] <- R2
        ADD R2, R2, #1
        ADD R4, R4, #1 ; moves to next memory slot
        ADD R3, R3, #-1
    BRp FOR_10_FILL
RET
; LOCAL DATA
DEC_10 .FILL #10
.END

;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3400
    ADD R2, R1, x0 ; R2 <- R1 ; index of memory
    AND R5, R5, x0
    ADD R5, R5, #10 ; R5 <- 10
    FOR_10_CONVERT
        ; get value (store into R3)
        LDR R3, R2, x0 ; R3 <- Mem[R2] 
        ; add 48
        LD R4, DEC_48
        ADD R3, R3, R4 ; R3 <- R3 + 48
        ; store it back
        STR R3, R2, x0 ; Mem[R2] <- R3
        ADD R2, R2 #1 ; R2 <- R2 + 1
        ADD R5, R5, #-1
    BRp FOR_10_CONVERT
RET
;LOCAL DATA
DEC_48 .FILL #48
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3600
    ADD R2, R1, x0 ; R2 <- R1 ; index of memory
    AND R5, R5, x0
    ADD R5, R5, #10 ; R5 <- 10
    FOR_10_PRINT
        LDR R0, R2, x0 ; R0 <- Mem[R2]
        OUT
        ADD R2, R2, #1
        ADD R5, R5, #-1
    BRp FOR_10_PRINT
RET
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3800
    LD R2, SUB_PRINT_ARRAY_2
    JSRR R2
    LD R0, COOL_STRING
    OUT
RET
SUB_PRINT_ARRAY_2 .FILL x3600
COOL_STRING .STRINGZ "====="
.END

.ORIG x4000
COOL_ARRAY .BLKW #10
.END