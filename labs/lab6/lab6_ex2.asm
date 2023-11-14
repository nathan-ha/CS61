;=================================================
; Name: Nathan Ha
; Email: nha023@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 21
; TA: 
; 
;=================================================

.ORIG x3000
LD R6, TOP_STACK_ADDR

; init stack
LD R5, BASE_ADDR
LD R3, BASE_ADDR
LD R4, MAX_ADDR


; push 5 times
AND R2, R2, x0
ADD R2, R2, #5
TEST_PUSHES_LOOP
    ; push 999 onto stack
    LD R1, DEC_999
    LD R0, SUB_STACK_PUSH
    JSRR R0
ADD R2, R2, #-1
BRp TEST_PUSHES_LOOP

; ; error push
; ; push 999 onto stack
; LD R1, DEC_999
; LD R0, SUB_STACK_PUSH
; JSRR R0


; pop 5 times
AND R2, R2, x0
ADD R2, R2, #5
TEST_POPS_LOOP
    LD R0, SUB_STACK_POP
    JSRR R0
ADD R2, R2, #-1
BRp TEST_POPS_LOOP

; error pop
; LD R0, SUB_STACK_POP
; JSRR R0

; push 111 onto stack
LD R1, DEC_111
LD R0, SUB_STACK_PUSH
JSRR R0


HALT
TOP_STACK_ADDR  .FILL xFE00

BASE_ADDR   .FILL xA000
MAX_ADDR    .FILL xA005

DEC_999     .FILL #999
DEC_111     .FILL #111
SUB_STACK_PUSH .FILL x3200
SUB_STACK_POP .FILL x3400

.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R5 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3200
; back up registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0
    ; check if stack is full (TOS>=MAX == TOS-MAX >= 0)
    NOT R4, R4
    ADD R4, R4, x1 ; 2's complement of MAX
    ADD R4, R4, R5 ; TOS - MAX
    BRn GOOD_PUSH ; if not >=0 (<0), then proceed to push 
    ; give error if full
    LEA R0, PUSH_ERROR_MSG
    PUTS
    BR PUSH_END
    
    ; push onto stack
    GOOD_PUSH
    ADD R5, R5, x1 ; move pointer up one
    STR R1, R5, x0 ; Mem[R5] <- R1
PUSH_END
; restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R2, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET

PUSH_ERROR_MSG .STRINGZ "Tried to push on a full stack!\n"

.END

.ORIG x3400
;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack and copied it to R0.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Values: R0 ← value popped off the stack
;		   R5 ← updated TOS
;------------------------------------------------------------------------------------------
; back up registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0
    ; check if stack is empty (TOS<=BASE == TOS-BASE<=0)
    NOT R3, R3
    ADD R3, R3, x1 ; 2's complement of BASE
    ADD R3, R3, R5 ; TOS - MAX
    BRp GOOD_POP ; if not <=0 (>0), then proceed to push 
    ; give error if empty
    LEA R0, POP_ERROR_MSG
    PUTS
    BR POP_END
    
    ; pop stack
    GOOD_POP
    ADD R5, R5, #-1 ; move pointer down one
POP_END
; restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R2, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET

POP_ERROR_MSG .STRINGZ "Tried to pop on a empty stack!\n"

.END