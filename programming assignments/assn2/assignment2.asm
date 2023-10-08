;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
    LEA R0, intro			; get starting address of prompt string
    PUTS			    	; Invokes BIOS routine to output string
    
;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
    
    ; get first number
    GETC
    ADD R1, R0, #0 ; R1 <- R0
    OUT
    LD R0, newline ; R0 <- '\n'
    OUT
    
    ; second number
    GETC
    ADD R2, R0, #0 ; R2 <- R0
    OUT
    LD R0, newline ; R0 <- '\n'
    OUT
    
    ; put numbers into string
    LEA R0, answer ; loads address of template answer into R0
    STR R1, R0, #0 ; Mem[R0 + 0] <- R1
    STR R2, R0, #4 ; Mem[R0 + 4] <- R2
    
    ; convert R2 to negative number
    ADD R2, R2, #-16 ; convert ascii to its corresponsing number value
    ADD R2, R2, #-16 ; have to repeat 3 times because -48 wouldn't fit in 5 bits
    ADD R2, R2, #-16
    NOT R2, R2
    ADD R2, R2, #1
    
    PUTS ; print first part of answer
    
    ADD R0, R1, R2 ; R4 <- R1 + R2 ; get sum
    
    ; check if negative
    ADD R4, R0, #0
    ADD R4, R4, #-16
    ADD R4, R4, #-16
    ADD R4, R4, #-16
    
    BRn IF_NEGATIVE
    END_IF
    
    ; print answer
    OUT
    LD R0, newline
    OUT

HALT				; Stop execution of program

; if negative, print a '-' followed by the magnitude of the number
IF_NEGATIVE 
    ADD R1, R0, #0 ; R1 <- R0
    LD R0, DEC_45 ; R0 <- '-'
    OUT
    ADD R1, R1, #-16 ; convert ascii to its corresponsing number value
    ADD R1, R1, #-16
    ADD R1, R1, #-16
    
    NOT R1, R1
    ADD R1, R1, #4 ; +1 for twos complement conversion, and +3 for ascii
    
    ADD R1, R1, #15 ; convert back to ascii
    ADD R1, R1, #15
    ADD R1, R1, #15
    ADD R0, R1, #0 ; R0 <- R1
BR END_IF
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT
answer .STRINGZ "F - S = "
DEC_45 .FILL #45
;---------------
;END of PROGRAM
;---------------	
.END

