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

; R4 holds negative flag
; R1 holds starting address of string
; R7 holds sum
; R0 holds current digit

.ORIG x3000		
;-------------
;Instructions
;-------------
LD R6, TOP_STACK_ADDR ; init stack

TOP_OF_CODE

; output intro prompt
LD R5, introPromptPtr
JSRR R5

; get input as string
LD R5, SUB_GET_STRING
LEA R1, STR_INPUT
JSRR R5
						

; Get first character, test for '\n', '+', '-', digit/non-digit 

; is it = '-'? if so, set neg flag, go get digits
LDR R2, R1, x0 ; R2 <- first char in string
; R3 = R2(first char) - R4('-')
LD R4, DEC_NEG_45_3000 ; 45 is '-'
ADD R3, R2, R4
; make R4 0 if positive, 1 for negative
BRz IF_INPUT_IS_NEGATIVE

; is it = '+'? if so, ignore it, go get digits
LDR R2, R1, x0 ; R2 <- first char in string
; R3 = R2(first char) - R4('+')
LD R4, DEC_NEG_43_3000 ; 43 is '+'
ADD R3, R2, R4
BRz IF_INPUT_IS_PLUS

; is very first character = '\n'? if so, just quit (no message)!
LDR R2, R1, x0 ; R2 <- first char in string
; R3 = R2(first char) - R4('\n')
LD R4, DEC_NEG_10_3000 ; 10 is '\n'
ADD R3, R2, R4
BRz IF_NEWLINE

AND R4, R4, x0 ; if this line is reached, then the number is positive
IF_FIRST_DIGIT_END

LD R0, DEC_10_3000
OUT
ADD R0, R1, x0
PUTS

; back up R1 and R4
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0

AND R5, R5, x0
ADD R2, R1, x0 ; R2 <- location in memory
STRING_LENGTH_LOOP
    ; get string length (store into R5 -> label)
    LDR R3, R2, x0 ; R3 <- ascii value at location
    LD R4, ASCII_NEG_x ; R5 <- sentinel char
    ADD R5, R5, x1
    ADD R2, R2, x1
    ADD R0, R3, R4 ; check if sentinel reached
BRnp STRING_LENGTH_LOOP
ADD R5, R5, #-1
ST R5, INPUT_LENGTH

LD R3, INPUT_LENGTH

LD R0, INPUT_LENGTH
AND R7, R7, x0
ADD R0, R0, #-1
IS_DIGIT_LOOP

    ; back up R0
    ADD R6, R6, #-1
    STR R0, R6, #0
    
    ; is it < '0'? if so, it is not a digit	- o/p error message, start over
    LDR R2, R1, x0 ; R2 <- first char in string
    ; R3 = R2(first char) - R5('0')
    LD R5, DEC_NEG_48_3000 ; 48 is '0'
    ADD R3, R2, R5
    BRn IF_ERROR
    
    ; is it > '9'? if so, it is not a digit	- o/p error message, start over
    LDR R2, R1, x0 ; R2 <- first char in string
    ; R3 = R2(first char) - R5('9')
    LD R5, DEC_NEG_57_3000 ; 57 is '9'
    ADD R3, R2, R5
    BRp IF_ERROR
    				
    ; if none of the above, first character is first numeric digit - convert it to number & store in target register!
    LD R3, DEC_NEG_48_3000
    LDR R2, R1, x0
    ADD R4, R2, R3 ; R4 <- R2 - R3 (first_char - 48) ; converts ascii to digit
    
    ; basically multiplying by 10 for the number of digits you have
    ; R4 holds digit for now
    ; LD R0, INPUT_LENGTH ; keeps the digit count
    ; ADD R3, R4, x0 ; R3 holds the original R4 value
    SHIFT_DECIMAL_LOOP
        LD R2, DEC_9_3000
        ADD R3, R4, x0 ; R3 holds the original R4 value
        MULTIPLY_10_LOOP
            ADD R4, R4, R3
            ADD R2, R2, #-1
        BRp MULTIPLY_10_LOOP
        ADD R0, R0, #-1
    Brp SHIFT_DECIMAL_LOOP
    
    ADD R7, R7, R4 ; store sum of digits
    					
    ; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
    ADD R1, R1, x1 ; next char
    
    ; restore R3
    LDR R0, R6, #0
    ADD R6, R6, #1
    
    ADD R0, R0, #-1
BRp IS_DIGIT_LOOP

; add last digit to R7
; ADD R1, R1, #1
LDR R0, R1, x0 ; store last ascii
LD R2, DEC_NEG_48_3000
ADD R4, R0, R2
ADD R7, R4, R7

; restore R1 and R4
LDR R4, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1

; TODO implement negative conversion
; TODO Convert binary to string

; remember to end with a newline!
				
HALT

IF_INPUT_IS_NEGATIVE
    AND R4, R4, x0
    ADD R4, R4, x1
    ADD R1, R1, x1
BR IF_FIRST_DIGIT_END

IF_INPUT_IS_PLUS
    ADD R1, R1, x1
    AND R4, R4, x0
BR IF_FIRST_DIGIT_END

IF_NEWLINE
    HALT

IF_ERROR
    LD R5, errorMessagePtr
    JSRR R5
BR TOP_OF_CODE
    


;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
TOP_STACK_ADDR  .FILL xFE00
SUB_GET_STRING  .FILL x3200
STR_INPUT       .STRINGZ "xxxxxxx" ; sentinel character will be a lowercase x
DEC_NEG_45_3000 .FILL #-45
DEC_NEG_10_3000 .FILL #-10
DEC_10_3000     .FILL #10
DEC_NEG_43_3000 .FILL #-43
STR_OUTPUT      .STRINGZ "0000 0000 0000 0000"
DEC_NEG_48_3000 .FILL #-48
DEC_NEG_57_3000 .FILL #-57
DEC_5_3000      .FILL #5
ASCII_NEG_x         .FILL #-120
INPUT_LENGTH    .BLKW #1
DEC_4_3000      .FILL #4
DEC_9_3000      .FILL #9

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

;---------------
; END of PROGRAM
;---------------
.END

.ORIG x3200
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Return: void
;-------------------------------------------------------------------------

; back upss
ADD R6, R6, #-1
STR R7, R6, #0

ADD R6, R6, #-1
STR R2, R6, #0

ADD R6, R6, #-1
STR R4, R6, #0

ADD R6, R6, #-1
STR R3, R6, #0



AND R2, R2, x0
AND R4, R4, x0 ; R4 <- 0
ADD R4, R1, x0 ; R4 <- R1
LD R5, DEC_6_3200
GET_STR_LOOP
    GETC
    ADD R3, R0, x0 ; R3 <- R0
    ADD R3, R3, #-10 ; R3 <- R3 - 10 ; break loop if user enters an enter
    BRz SKIP_IF_ENTER ; skip printing/storing the enter
    OUT
    STR R0, R4, x0 ; R4 <- R0
    ADD R4, R4, #1
    
    ADD R5, R5, #-1 ; quit the program if more than 5 chars are input
    BRz MAX_LOOPS_3200
SKIP_IF_ENTER
BRnp GET_STR_LOOP


; restore registers

LDR R3, R6, #0
ADD R6, R6, #1

LDR R4, R6, #0
ADD R6, R6, #1

LDR R2, R6, #0
ADD R6, R6, #1

LDR R7, R6, #0
ADD R6, R6, #1

MAX_LOOPS_3200
RET

DEC_6_3200 .FILL #6

.end

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
