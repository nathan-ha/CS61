;=================================================
; Name: Nathan Ha
; Email: 
; 
; Lab: lab 5, ex 2
; Lab section: 
; TA: 
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

; prompt user
LEA R0, STR_MSG_PROMPT ; R0 <- "Enter some text\n"
PUTS

; get user input
LEA R1, STR_USER_INPUT
LD R5, SUB_GET_STRING
JSRR R5

; prints newline
AND R0, R0, x0
ADD R0, R0, #10
OUT

LD R4, SUB_IS_PALINDROME
JSRR R4

LD R3, SUB_TO_UPPER
JSRR R3

; test (prints result)
LEA R0, STR_THE_STRING
PUTS
ADD R0, R1, x0
PUTS
LEA R0, STR_IS
PUTS
ADD R4, R4, x0
BRz IF_NOT_PALINDROME
    IF_NOT_PALINDROME_END
LEA R0, STR_A_PALINDROME
PUTS


; prints newline
AND R0, R0, x0
ADD R0, R0, #10
OUT

HALT

IF_NOT_PALINDROME
LEA R0, STR_NOT
PUTS
BR IF_NOT_PALINDROME_END

; your local data goes here
SUB_GET_STRING .FILL x3200
STR_MSG_PROMPT .STRINGZ "Enter some text\n"
STR_USER_INPUT .BLKW #100
SUB_IS_PALINDROME .FILL x3400
STR_THE_STRING .STRINGZ "The string "
STR_IS .STRINGZ " IS "
STR_NOT .STRINGZ "NOT "
STR_A_PALINDROME .STRINGZ "a palindrome"
SUB_TO_UPPER .FILL x3600

top_stack_addr .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
.end

; your subroutines go below here
.orig x3200
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
AND R2, R2, x0
AND R4, R4, x0 ; R4 <- 0
ADD R4, R1, x0 ; R4 <- R1
AND R5, R5, x0 ; R5 <- 0
GET_STR_LOOP
    GETC
    ADD R5, R5, #1 ; count # of chars
    ADD R3, R0, x0 ; R3 <- R0
    ADD R3, R3, #-10 ; R3 <- R3 - 10 ; break loop if user enters an enter
    BRz SKIP_IF_ENTER ; skip printing/storing the enter
    OUT
    STR R0, R4, x0 ; R4 <- R0
    ADD R4, R4, #1
SKIP_IF_ENTER
BRnp GET_STR_LOOP

ADD R5, R5, #-1 ; remove the one from the enter

RET
.end


.orig x3400
;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
; registers: R2 holds beginning index (i), R3 holds end index (n - i - 1), R4 holds beginning character, R5, holds end character, R6 holds difference between the two
; check if Mem[R2] and Mem[R3] are the same, stop when they are not or R2 == R3

ADD R2, R1, #0 ; R2 <- string starting index
ADD R3, R1, R5 ; R3 <- first_index + size
ADD R3, R3, #-1 ; R3 <- last string index in memory


IS_PALINDROME_LOOP

; check if start reached end
; convert R3 to negative
NOT R3, R3
ADD R3, R3, x1
ADD R6, R3, R2 ; R6 <- R2 - R3
BRzp EXIT_TRUE_IS_PALINDROME
; convert R3 back
NOT R3, R3
ADD R3, R3, x1

; check if start char equals end char
LDR R4, R2, x0 ; R4 <- Mem[R2]
LDR R5, R3, x0 ; R5 <- Mem[R3]
; convert R5 to negative
NOT R5, R5
ADD R5, R5, x1
; R4 - R5 ; if both character are not the same
ADD R6, R4, R5
BRnp EXIT_IS_PALINDROME

; move pointers
ADD R2, R2, #1
ADD R3, R3, #-1

BR IS_PALINDROME_LOOP


EXIT_TRUE_IS_PALINDROME
AND R4, R4, x0 ; R4 <- 0 ; return 0 for not palindrome
ADD R4, R4, x1 ; R4 <- 1
RET

EXIT_IS_PALINDROME
AND R4, R4, x0 ; R4 <- 0 ; return 0 for not palindrome
RET

.end

.orig x3600
;-------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case
;     in-place i.e. the upper-case string has replaced the original string
; No return value, no output, but R1 still contains the array address, unchanged
;-------------------------------------------------------------------------
ADD R2, R1, x0 ; R2 <- index of string
LD R5, CAPS_MASK

TO_UPPER_LOOP
; TODO: no idea if this works
LDR R3, R2, x0 ; R3 <- Mem[R2]
AND R6, R3, R5 ; R4 <- R3 AND MASK
STR R6, R2, x0 ; put new value back into string
ADD R2, R2, x1
ADD R3, R3, x0 ; just to check if 0 is reached
BRnp TO_UPPER_LOOP

RET

CAPS_MASK .FILL xDF ; mask of 11011111
.end