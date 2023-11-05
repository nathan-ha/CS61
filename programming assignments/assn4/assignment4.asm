;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 21
; TA: Karan, Nick
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------
; R3 holds negative flag
; R4 holds number size
; R1 holds start address of string


TOP_OF_CODE

LD R6, TOP_STACK_ADDR ; init stack
AND R4, R4, x0 ; R4 counts number of numbers

LD R1, introPromptPtr
JSRR R1

LEA R1, STR_INPUT
LD R7, DEC_5_3000 ; used for counting grabbed chars

; get first character
GETC ; R0 <- input

AND R3, R3, x0
; check if negative
LD R2, DEC_NEG_45_3000
ADD R2, R2, R0 ; R2 <- (char) - '-'
BRz IS_NEGATIVE
; check if positive
LD R2, DEC_NEG_43_3000
ADD R2, R2, R0 ; R2 <- (char) - '+'
BRz IS_NEGATIVE_END

; check if newline
LD R2, DEC_NEG_10_3000
ADD R2, R0, R2 ; R2 <- (char) - '\n'
BRz IS_NEWLINE

; check if any non-numeric input
; R4 = R2(first char) - R5('0')
LD R5, DEC_NEG_48_3000 ; 48 is '0'
ADD R5, R0, R5
BRn IF_ERROR

; is it > '9'
; R4 = R0(first char) - R5('9')
LD R5, DEC_NEG_57_3000 ; 57 is '9'
ADD R5, R0, R5
BRp IF_ERROR

OUT
; put number into string
ADD R0, R0, #-16
ADD R0, R0, #-16 ; lazy ascii conversion
ADD R0, R0, #-16
; store first char into string
STR R0, R1, x0 ; char -> R1 (mem add.)
ADD R1, R1, x1
ADD R4, R4, x1

ADD R7, R7, #-1

BR SKIP_PRINTING_SIGN

IS_NEGATIVE_END

OUT

SKIP_PRINTING_SIGN


; back up register
ADD R6, R6, #-1
STR R3, R6, #0

; get rest of chars
; TODO if there are no numbers after +-
GET_CHARS
    
    GETC ; R0 <- input
    
    ; check if newline
    LD R2, DEC_NEG_10_3000
    ADD R2, R0, R2 ; R2 <- (char) - '\n'
    BRz IS_NEWLINE_2
    
    ; check if any non-numeric input
    ; R3 = R2(first char) - R5('0')
    LD R5, DEC_NEG_48_3000 ; 48 is '0'
    ADD R3, R0, R5
    BRn IF_ERROR
    
    ; is it > '9'
    ; R3 = R2(first char) - R5('9')
    LD R5, DEC_NEG_57_3000 ; 57 is '9'
    ADD R3, R0, R5
    BRp IF_ERROR
    
    OUT
    ; store character in string
    ADD R0, R0, #-16
    ADD R0, R0, #-16 ; lazy ascii conversion
    ADD R0, R0, #-16
    
    STR R0, R1, x0 ; char -> R1 (mem add.)
    ADD R1, R1, x1
    
    ADD R4, R4, #1 ; increment character size
    ADD R7, R7, #-1
BRp GET_CHARS
    
IS_NEWLINE_2 ; jumps here if an enter is pressed


AND R3, R3, x0 ; holds total sum

ADD R2, R4, #-1
BRz ONE_DIGIT_INPUT

ADD R4, R4, #-1 ; subtracting because idk I'm so tired rn
LEA R1, STR_INPUT
FOR_EACH_CHAR
    ; back up R4
    ADD R6, R6, #-1
    STR R4, R6, #0
    
    ; basically multiplying by 10^d for each digit
    ; R1 holds digit address
    ; R2 holds digit value
    ; R3 holds sum
    LDR R2, R1, x0
    SHIFT_DECIMAL_LOOP
        LD R7, DEC_9_3000
        ADD R5, R2, x0 ; R5 holds the original R2 value
        MULTIPLY_10_LOOP
            ADD R2, R2, R5
            ADD R7, R7, #-1
        BRp MULTIPLY_10_LOOP
        ADD R4, R4, #-1
    Brp SHIFT_DECIMAL_LOOP
    
    ADD R3, R3, R2 ; add to total sum
    
    LDR R4, R6, #0 ; restore R4
    ADD R6, R6, #1
    
    ADD R1, R1, x1
    ADD R4, R4, #-1
BRp FOR_EACH_CHAR

; last digit handled separately
LDR R2, R1, x0
ADD R3, R3, R2 ; add to total sum

ADD R4, R3, x0 ; R4 must have the final value
ONE_DIGIT_INPUT_END

; restore registers
LDR R3, R6, #0 ; holds negative flag again
ADD R6, R6, #1


; convert to negative if flag is 1
ADD R3, R3, x0
BRp CONVERT_TO_NEGATIVE
CONVERT_TO_NEGATIVE_END

; ; newline
; LD R0, DEC_10_3000
; OUT


HALT


IF_ERROR
    LD R0, DEC_10_3000
    OUT
    LD R5, errorMessagePtr
    JSRR R5
BR TOP_OF_CODE

CONVERT_TO_NEGATIVE
    NOT R4, R4
    ADD R4, R4, x1
BR CONVERT_TO_NEGATIVE_END

IS_NEGATIVE
    AND R3, R3, x0
    ADD R3, R3, #1
BR IS_NEGATIVE_END

IS_NEWLINE
HALT

ONE_DIGIT_INPUT
    LD R4, STR_INPUT
BR ONE_DIGIT_INPUT_END



;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
TOP_STACK_ADDR  .FILL xFE00
SUB_GET_STRING  .FILL x3200
STR_INPUT       .BLKW   #8 ; sentinel character will be a 0
DEC_NEG_45_3000 .FILL #-45
DEC_NEG_10_3000 .FILL #-10
DEC_10_3000     .FILL #10
DEC_NEG_43_3000 .FILL #-43
DEC_NEG_48_3000 .FILL #-48
DEC_NEG_57_3000 .FILL #-57
DEC_5_3000      .FILL #5
ASCII_NEG_x         .FILL #-120
ASCII_x         .FILL #120
INPUT_LENGTH    .BLKW #1
DEC_4_3000      .FILL #4
DEC_9_3000      .FILL #9
MASK_LEADING_DIGIT .FILL x8000
ASCII_1        .FILL #49
DEC_7           .FILL #7
DEC_8           .FILL #8
DEC_6_3000      .FILL #6

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt

; back ups (R0 and 7)
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0

    LEA R0, STR_PROMPT
    PUTS
    
; restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

STR_PROMPT .STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message

; back ups (R0 and 7)
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0

    LEA R0, STR_ERROR
    PUTS
    
; restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

STR_ERROR .STRINGZ	 "ERROR: invalid input\n"

RET

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
