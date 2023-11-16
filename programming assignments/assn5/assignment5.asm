; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: Karan and Nick
; TA: 21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
LEA R1, user_string
LEA R0, user_prompt
PUTS

; get a string from the user (string location in R1)
LD R5, get_user_string_addr
JSRR R5

AND R0, R0, x0
ADD R0, R0, #10 ; print newline
OUT

; find size of input string
LD R5, strlen_addr
JSRR R5

; call palindrome method
ADD R2, R2, R1
ADD R2, R2, #-1 ; R2 <- address of the last character
LD R5, palindrome_addr
JSRR R5

; determine if storng is a palindrome
; idk what to do here, the palindrome is determined above

; print the result to the screen
LEA R0, result_string
PUTS

; decide whether or not to print "not"
ADD R3, R3, x0
BRp SKIP_NOT

LEA R0, not_string
PUTS

SKIP_NOT
LEA R0, final_string
PUTS

HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ   "Enter a string: "
result_string        .STRINGZ   "The string is "
not_string           .STRINGZ   "not "
final_string         .STRINGZ   "a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  100

.END

;---------------------------------------------------------------------------------
; get_user_string - takes a string from the user and stores it into memory
;
; parameter: R1 - starting address of the string
;
; returns: nothing (R1 is still the same address)
;---------------------------------------------------------------------------------
.ORIG x3200
get_user_string
; Backup all used registers, R7 first, using proper stack discipline
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

WHILE_NOT_ENTER_3200
    GETC ; R0 <- input
    ADD R2, R0, #-10 ; checks if an enter is entered
    BRz WHILE_NOT_ENTER_3200_END
    STR, R0, R1, x0 ; store character (Mem[R1] <- R0)
    OUT
    ADD R1, R1, #1 ; go to next position
BR WHILE_NOT_ENTER_3200
WHILE_NOT_ENTER_3200_END
; there is already a zero at the end from the blkw

; Restire all used registers, R7 last, using proper stack discipline
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
.END


;---------------------------------------------------------------------------------
; strlen - counts number of characters in a string; stops when a null character is reached
;
; parameter: R1 - starting address of the string
;
; returns: R2 - length of string
;---------------------------------------------------------------------------------
.ORIG x3300
strlen
; Backup all used registers, R7 first, using proper stack discipline
ADD R6, R6, #-1
STR R7, R6, #0 ; back up R7
ADD R6, R6, #-1
STR R5, R6, #0 ; back up R5
ADD R6, R6, #-1
STR R4, R6, #0 ; back up R4
ADD R6, R6, #-1
STR R3, R6, #0 ; back up R3
ADD R6, R6, #-1
STR R1, R6, #0 ; back up R1
ADD R6, R6, #-1
STR R0, R6, #0 ; back up R0

AND R2, R2, x0 ; R2 <- 0
WHILE_NOT_NULL_3300
    LDR R0, R1, x0 ; R0 <- character at R1
    BRz WHILE_NOT_NULL_3300_END
    ADD R1, R1, x1
    ADD R2, R2, x1 ; increment number of chars
BR WHILE_NOT_NULL_3300
WHILE_NOT_NULL_3300_END

; Resture all used registers, R7 last, using proper stack discipline
LDR R0, R6, #0 ; restore R0
ADD R6, R6, #1
LDR R1, R6, #0 ; restore R1
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
.END


;---------------------------------------------------------------------------------
; palindrome - checks if the string is the same when it gets reversed
;
; parameter: R1 - starting address of the string
;            R2 - address of last character of string
;
; returns:  R3 - 1 if IS a palindrome, 0 if NOT a palindrome
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
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

; if (beg >= end) return true;
; if (beg-end >= 0) ...
NOT R7, R2;
ADD R7, R7, x1 ; twos complement of end

ADD R0, R1, R7 ; beg-end
BRzp return_true_3400

; if (*beg != *end) return false;
; if (*beg-*end != 0) ...
LDR R5, R1, x0 ; R5 <- character at start
LDR R7, R2, x0 ; R7 <- character at end

NOT R7, R7
ADD R7, R7, x1 ; twos complement of end value

ADD R0, R5, R7 ; *beg-*end is nonzero
BRnp return_false_3400

; return is_palindrome(++beg, --end);
ADD R1, R1, x1 ; beg++
ADD R2, R2, #-1 ; end--
LD R5, palindrome_addr_3400
JSRR R5

palindrome_end
; Resture all used registers, R7 last, using proper stack discipline
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

return_true_3400
    AND R3, R3, x0
    ADD R3, R3, x1
BR palindrome_end

return_false_3400
    AND R3, R3, x0
BR palindrome_end

palindrome_addr_3400 .FILL x3400
.END
