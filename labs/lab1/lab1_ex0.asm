;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
;--------------
; Instructions
;--------------
    ; note: LD loads value, LEA loads memory address
    LEA R0, MSG_TO_PRINT ; R0 <- MSG_TO_PRINT
    PUTS                 ; Prints string defined at MSG_TO_PRINT
    
    HALT                 ; terminates program

;-------------
; Local Data
;-------------
    MSG_TO_PRINT .STRINGZ "Hello world!!!\n"
    
.END