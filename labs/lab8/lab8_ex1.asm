;=================================================
; Name: Nathan Ha
; Email: 
; 
; Lab: lab 8, ex 1
; Lab section: 
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LD R5, LOAD_FILL_VALUE_3200
JSRR R5

LD R5, OUTPUT_AS_DECIMAL_3400
JSRR R5


HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE_3200 .FILL x3200
OUTPUT_AS_DECIMAL_3400 .FILL x3400

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: none
; Postcondition: will load #999 into R1
; Return Value: R1
;=================================================

.orig x3200

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0 ; back up R7
ADD R6, R6, #-1
STR R5, R6, #0 ; back up R5
ADD R6, R6, #-1
STR R4, R6, #0 ; back up R4
ADD R6, R6, #-1
STR R3, R6, #0 ; back up R3
ADD R6, R6, #-1
STR R2, R6, #0 ; back up R2
ADD R6, R6, #-1
STR R0, R6, #0 ; back up R0

; Code
LD R1, VALUE
    

; Restore registers
LDR R0, R6, #0 ; restore R0
ADD R6, R6, #1
LDR R2, R6, #0 ; restore R2
ADD R6, R6, #1
LDR R3, R6, #0 ; restore R3
ADD R6, R6, #1
LDR R4, R6, #0 ; restore R4
ADD R6, R6, #1
LDR R5, R6, #0 ; restore R5
ADD R6, R6, #1
LDR R7, R6, #0 ; restore R7
ADD R6, R6, #1

RET

VALUE .FILL #32767

.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: R1
; Postcondition: outputs to console the number in R1 as a decimal
; Return Value: none
;=================================================

.orig x3400

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0 ; back up R7
ADD R6, R6, #-1
STR R5, R6, #0 ; back up R5
ADD R6, R6, #-1
STR R4, R6, #0 ; back up R4
ADD R6, R6, #-1
STR R3, R6, #0 ; back up R3
ADD R6, R6, #-1
STR R2, R6, #0 ; back up R2
ADD R6, R6, #-1
STR R1, R6, #0 ; back up R1
ADD R6, R6, #-1
STR R0, R6, #0 ; back up R0

; Code
; if negative, convert to positive and output '-'
IF_R1_NEGATIVE
ADD R1, R1, x0
BRzp IF_R1_NEGATIVE_END
    NOT R1, R1
    ADD R1, R1, x1
    LD R0, DEC_45_3400
    OUT
IF_R1_NEGATIVE_END

; print each digit
; 5 digit
ADD R2, R1, x0 ; R2 <- R1
LD R3, DEC_-10000_3400 ; R3 <- digit place
AND R4, R4, x0 ; R4 <- counter
DIGIT_LOOP_10000
    ADD R2, R2, R3;
    BRnz DIGIT_LOOP_10000_END
    ADD R4, R4, x1
    BR DIGIT_LOOP_10000
DIGIT_LOOP_10000_END

; print counter
ADD R0, R4, x0
ADD R0, R0, #15
ADD R0, R0, #15 ; lazy ascii conversion
ADD R0, R0, #15
ADD R0, R0, #3
OUT

; remove first digit
IF_R1_HAS_5_DIGITS
ADD R4, R4, x0
BRnz IF_R1_HAS_5_DIGITS_END
    ADD R1, R1, R3 ; R1 <- R1 - 10000
    ADD R4, R4, #-1
    BR IF_R1_HAS_5_DIGITS
IF_R1_HAS_5_DIGITS_END

; 4 digit
ADD R2, R1, x0 ; R2 <- R1
LD R3, DEC_-1000_3400 ; R3 <- digit place
AND R4, R4, x0 ; R4 <- counter
DIGIT_LOOP_1000
    ADD R2, R2, R3;
    BRnz DIGIT_LOOP_1000_END
    ADD R4, R4, x1
    BR DIGIT_LOOP_1000
DIGIT_LOOP_1000_END

; print counter
ADD R0, R4, x0
ADD R0, R0, #15
ADD R0, R0, #15 ; lazy ascii conversion
ADD R0, R0, #15
ADD R0, R0, #3
OUT

; remove first digit
IF_R1_HAS_4_DIGITS
ADD R4, R4, x0
BRnz IF_R1_HAS_4_DIGITS_END
    ADD R1, R1, R3 ; R1 <- R1 - 10000
    ADD R4, R4, #-1
    BR IF_R1_HAS_4_DIGITS
IF_R1_HAS_4_DIGITS_END

; 3 digit
ADD R2, R1, x0 ; R2 <- R1
LD R3, DEC_-100_3400 ; R3 <- digit place
AND R4, R4, x0 ; R4 <- counter
DIGIT_LOOP_100
    ADD R2, R2, R3;
    BRnz DIGIT_LOOP_100_END
    ADD R4, R4, x1
    BR DIGIT_LOOP_100
DIGIT_LOOP_100_END

; print counter
ADD R0, R4, x0
ADD R0, R0, #15
ADD R0, R0, #15 ; lazy ascii conversion
ADD R0, R0, #15
ADD R0, R0, #3
OUT

; remove first digit
IF_R1_HAS_3_DIGITS
ADD R4, R4, x0
BRnz IF_R1_HAS_3_DIGITS_END
    ADD R1, R1, R3 ; R1 <- R1 - 10000
    ADD R4, R4, #-1
    BR IF_R1_HAS_3_DIGITS
IF_R1_HAS_3_DIGITS_END

; 2 digit
ADD R2, R1, x0 ; R2 <- R1
LD R3, DEC_-10_3400 ; R3 <- digit place
AND R4, R4, x0 ; R4 <- counter
DIGIT_LOOP_10
    ADD R2, R2, R3;
    BRnz DIGIT_LOOP_10_END
    ADD R4, R4, x1
    BR DIGIT_LOOP_10
DIGIT_LOOP_10_END

; print counter
ADD R0, R4, x0
ADD R0, R0, #15
ADD R0, R0, #15 ; lazy ascii conversion
ADD R0, R0, #15
ADD R0, R0, #3
OUT

; remove first digit
IF_R1_HAS_2_DIGITS
ADD R4, R4, x0
BRnz IF_R1_HAS_2_DIGITS_END
    ADD R1, R1, R3 ; R1 <- R1 - 10000
    ADD R4, R4, #-1
    BR IF_R1_HAS_2_DIGITS
IF_R1_HAS_2_DIGITS_END

; 1 digit
ADD R2, R1, x0 ; R2 <- R1
LD R3, DEC_-1_3400 ; R3 <- digit place
AND R4, R4, x0 ; R4 <- counter
DIGIT_LOOP_1
    ADD R2, R2, R3;
    BRnz DIGIT_LOOP_1_END
    ADD R4, R4, x1
    BR DIGIT_LOOP_1
DIGIT_LOOP_1_END

; print counter
ADD R0, R4, x1
ADD R0, R0, #15
ADD R0, R0, #15 ; lazy ascii conversion
ADD R0, R0, #15
ADD R0, R0, #3
OUT


; Restore registers
LDR R0, R6, #0 ; restore R0
ADD R6, R6, #1
LDR R1, R6, #0 ; restore R1
ADD R6, R6, #1
LDR R2, R6, #0 ; restore R2
ADD R6, R6, #1
LDR R3, R6, #0 ; restore R3
ADD R6, R6, #1
LDR R4, R6, #0 ; restore R4
ADD R6, R6, #1
LDR R5, R6, #0 ; restore R5
ADD R6, R6, #1
LDR R7, R6, #0 ; restore R7
ADD R6, R6, #1

RET

DEC_45_3400     .FILL #45
DEC_-10000_3400  .FILL #-10000
DEC_-1000_3400   .FILL #-1000
DEC_-100_3400    .FILL #-100
DEC_-10_3400     .FILL #-10
DEC_-1_3400      .FILL #-1

.end