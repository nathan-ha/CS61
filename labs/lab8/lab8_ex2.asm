;=================================================
; Name: Nathan Ha
; Email: 
; 
; Lab: lab 8, ex 2
; Lab section: 
; TA: 
; 
;=================================================

; ===================
; EX 3 ANSWERS
; algorithm: 
;   set lsb to 0 // it just works
;   start loop
;      save msb
;      left shift
;      add saved msb to the end
;      repeat n-1 times, where n is the number of bits
;   end loop
;   
;   since this only works on unsigned,
;   in twos complement, save the original sign of the number, convert to positive if not already
;   after algorithm runs, convert it back to the original sign
; ===================
.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LEA R0, prompt
PUTS
GETC

LD R5, PARITY_CHECK_3600
JSRR R5

; print result
ADD R0, R3, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT


HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
prompt .stringz "Input a single digit\n"
PARITY_CHECK_3600 .FILL x3600


.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: R0
; Postcondition: counts the number of binary 1's in R0
; Return Value (R3): the number of binary 1's in R0
;=================================================

.orig x3600

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0 ; back up R7
ADD R6, R6, #-1
STR R5, R6, #0 ; back up R5
ADD R6, R6, #-1
STR R4, R6, #0 ; back up R4
ADD R6, R6, #-1
STR R2, R6, #0 ; back up R2
ADD R6, R6, #-1
STR R1, R6, #0 ; back up R1
ADD R6, R6, #-1
STR R0, R6, #0 ; back up R0

; Code
    AND R3, R3, x0 ; counter
    COUNT_ONES_LOOP
        IF_ONE
            ADD R0, R0, x0
            BRzp IF_ONE_END
            ADD R3, R3, x1 ; increment counter
        IF_ONE_END
    ADD R0, R0, R0 ; left shift
    BRnp COUNT_ONES_LOOP

; Restore registers
LDR R0, R6, #0 ; restore R0
ADD R6, R6, #1
LDR R1, R6, #0 ; restore R1
ADD R6, R6, #1
LDR R2, R6, #0 ; restore R2
ADD R6, R6, #1
LDR R4, R6, #0 ; restore R4
ADD R6, R6, #1
LDR R5, R6, #0 ; restore R5
ADD R6, R6, #1
LDR R7, R6, #0 ; restore R7
ADD R6, R6, #1

RET

.end