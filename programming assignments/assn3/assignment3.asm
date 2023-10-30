;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 21
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
    ;-------------
    ;Instructions
    ;-------------
    LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
    LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
    LD R3, MSB_MASK        ; R3 <-- x8000
    LD R4, DEC_3           ; R4 <-- #3 (counter variable)
    LD R5, DEC_48           ; R4 <-- #48
    ;-------------------------------
    ;INSERT CODE STARTING FROM HERE
    ;--------------------------------
    
    ; goal: print out binary number
    
    DO_WHILE
        AND R0, R0, x0      ; R0 <- x0
        ; get most significant bit
        AND R2, R1, R3      ; R2 <-- R1 AND R3 <-- most significant bit 
        ; print 1 if its 1 or 0 if 0
        BRn ONE_CASE_4 ; numbering is weird because i messed up and didn't want to rewrite numbers
        CASES_END_4
        ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
        OUT
        ; left shift (multiply by two)
        ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
    
        ; these next 3 blocks of code are literally the same thing; i duplicated them like that to separate the nibbles by spaces
        AND R0, R0, x0      ; R0 <- x0
        AND R2, R1, R3      ; R2 <-- R1 AND R3 
        BRn ONE_CASE_1
        CASES_END_1
        ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
        OUT
        ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
        AND R0, R0, x0      ; R0 <- x0
        AND R2, R1, R3      ; R2 <-- R1 AND R3 
        BRn ONE_CASE_2
        CASES_END_2
        ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
        OUT
        ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
        AND R0, R0, x0      ; R0 <- x0
        AND R2, R1, R3      ; R2 <-- R1 AND R3 
        BRn ONE_CASE_3
        CASES_END_3
        ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
        OUT
        ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
        LD R0, SPACE      ; R0 <-- ' '
        OUT
        
        ; repeat 3 times
        ADD R4, R4, #-1
        BRp DO_WHILE
    DO_WHILE_END
    
    ; this chunk of code is so that a space is not printed at the end
    AND R0, R0, x0      ; R0 <- x0
    AND R2, R1, R3      ; R2 <-- R1 AND R3 
    BRn ONE_CASE_5
    CASES_END_5
    ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
    OUT
    ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
    AND R0, R0, x0      ; R0 <- x0
    AND R2, R1, R3      ; R2 <-- R1 AND R3 
    BRn ONE_CASE_6
    CASES_END_6
    ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
    OUT
    ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
    AND R0, R0, x0      ; R0 <- x0
    AND R2, R1, R3      ; R2 <-- R1 AND R3 
    BRn ONE_CASE_7
    CASES_END_7
    ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
    OUT
    ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
    AND R0, R0, x0      ; R0 <- x0
    AND R2, R1, R3      ; R2 <-- R1 AND R3 
    BRn ONE_CASE_8
    CASES_END_8
    ADD R0, R0, R5      ; R0 <-- R0 + #48 ; convert to ascii
    OUT
    ADD R1, R1, R1      ; R1 <-- R1 +  R1
    
    LD R0, NEWLINE
    OUT

HALT

ONE_CASE_1
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_1

ONE_CASE_2
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_2

ONE_CASE_3
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_3

ONE_CASE_4
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_4

ONE_CASE_5
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_5

ONE_CASE_6
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_6

ONE_CASE_7
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_7

ONE_CASE_8
    LD R0, DEC_1        ; R0 <- #1
BR CASES_END_8

;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
MSB_MASK .FILL x8000 ; equivalent to a binary 1 followed by 15 zeroes
DEC_1 .FILL #1
DEC_3 .FILL #3
DEC_48 .FILL #48
SPACE .FILL #32
NEWLINE .FILL #10

.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
