;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 21
; TA: Nicholas Santini, Karan Bhogal
; 
; I hereby certify that I did not come up with any of this code...
;
;=========================================================================

;---------------------------------------------------------------------------------------
;           BUILD TABLE HERE
;---------------------------------------------------------------------------------------
; REG VALUES        R0      R1      R2      R3      R4      R5      R6      R7
;---------------------------------------------------------------------------------------
; Pre-Loop          6       12      0       0       0       0       0       0   
; Iteration 1       5       12      12      0       0       0       0       0
; Iteration 2       4       12      24      0       0       0       0       0
; Iteration 3       3       12      36      0       0       0       0       0
; Iteration 4       2       12      48      0       0       0       0       0
; Iteration 5       1       12      60      0       0       0       0       0
; Iteration 6       0       12      72      0       0       0       0       0
; End of Program    0       32767   12      72      0       0       12286   0
;---------------------------------------------------------------------------------------


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------

LD R1, DEC_6    ; R1 <- 6
LD R2, DEC_12   ; R2 <- 12
AND R3, R3, #0  ; R3 <- 0

DO_WHILE ADD R3, R3, R2  ; R3 <- R3 + R2
         ADD R1, R1, #-1 ; R1 <- R1 - 1
         BRp DO_WHILE    ; if (LMR>0) goto DO_WHILE
         
HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

DEC_6   .FILL    #6 ; put 6 into memory at address with this label
DEC_12  .FILL    #12



;---------------	
; END of PROGRAM
;---------------	
.END


