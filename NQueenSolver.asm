

;---------------------Main program

.orig x3000


;init stack
LEA R6, STACK

LD R1, HALF_STACK_SIZE
ADD R1,R1,R1 ; R1 = R1*2 = 400

ADD R6,R6,R1


;solve queen problem
JSR nQueenSolver



HALT

;main Values
HALF_STACK_SIZE .FILL #200
STACK .BLKW #400
;----------------- End Main Program



;-------------------------- GetNum function 
; action: inputs a number and prints it

GetNum

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,R5)

STR R7, R6, #0 ; saving R7
STR R1, R6, #1 ; saving R1
STR R2, R6, #2 ; saving R2
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4
STR R5, R6, #5 ; saving R5

AND R1,R1,#0 		; reset r1 will
LD R3,asciiNormal 	; load -48 into r3 ascii value of 0
ADD R4, R1, #10 	; r4 = 10 (for mul)

LOOP

GETC	       		; gets a digit as input
ADD R2,R0,#-10 		; check if ro is equal 10
BRz ENDLOOP    		; if ascii value is 10 so the number was over
OUT	       		; print the input digit
ADD R5,R0,#0   		; r5 hold the ascii value of the input

; CALLER:
STR R1, R6, #-2 
STR R4, R6, #-1
ADD R6,R6,#-2


JSR Mul        		; multiply by 10

ADD R6,R6,#2

ADD R1,R0,#0
ADD R5,R5,R3   		; the real value of the digit
ADD R1,R1,R5   		; add the input digit to %10 field
 
BR LOOP


ENDLOOP

ADD R0,R1,#0

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R7, R6, #0 ; loading R7
LDR R1, R6, #1 ; loading R1
LDR R2, R6, #2 ; loading R2
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R4

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET


HALT
asciiNormal .fill #-48
;--------------------------- end GetNum function



;--------------------------- print num function
;get a number and print it

PrintNum

;CALLE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0

ST R0 VALUE_R0

LDR R0 R6 #6		;R0=NUM

;CHECK IF R0 IS POSITIVE
;IF POS - PRINTS
;IF NEG - MAKE IT POS AND PRINT MINUS

ADD R0 R0 #0
BRzp CONT_PRINT_NUM

NOT R0 R0 
ADD R4 R0 #1

LD R0 ASCII_MINUS_PRINT
OUT
ADD R0 R4 #0

CONT_PRINT_NUM

AND R1 R1 #0
ADD R1 R1 #10		;R1=10
STR R1 R6 #-1
STR R0 R6 #-2
ADD R6 R6 #-2

JSR EfficientDivFunc	;MAKE R0/10

LDR R2 R0 #1		;R2=SIFRAT AHADOT
LDR R0 R0 #0		;R0=NUM

ADD R6 R6 #2
AND R1 R1 #0
ADD R1 R1 #10
STR R1 R6 #-1
STR R0 R6 #-2
ADD R6 R6 #-2

JSR EfficientDivFunc

LDR R3 R0 #1		;R3=SIFRAT ASAROT
LDR R0 R0 #0		;R0=NUM
ADD R6 R6 #2


AND R1 R1 #0
ADD R1 R1 #10
STR R1 R6 #-1
STR R0 R6 #-2
ADD R6 R6 #-2

JSR EfficientDivFunc

LDR R4 R0 #1		;R4=SIFRAT MAOOT
LDR R0 R0 #0		;R0=NUM
ADD R6 R6 #2


AND R1 R1 #0
ADD R1 R1 #10
STR R1 R6 #-1
STR R0 R6 #-2
ADD R6 R6 #-2

JSR EfficientDivFunc

LDR R5 R0 #1		;R5=SIFRAT ALLAFIM
LDR R0 R0 #0		;R0=SIFRAT ASSAROTÉALAFIM
ADD R6 R6 #2


LD R7 ASCII_0

ADD R0 R0 #0
BRz NoASAROTALAFIM
;MAKE IT DIGITS
ADD R2 R2 R7
ADD R3 R3 R7
ADD R4 R4 R7
ADD R5 R5 R7 
ADD R0 R0 R7
;PRINTS DIGITS
ADD R0 R0 #0
OUT
ADD R0 R5 #0
OUT
ADD R0 R4 #0
OUT
ADD R0 R3 #0
OUT
ADD R0 R2 #0
OUT
BR FINISH_PRINT


NoASAROTALAFIM
ADD R5 R5 #0
BRz NoALAFIM
;MAKE IT DIGITS
ADD R2 R2 R7
ADD R3 R3 R7
ADD R4 R4 R7
ADD R5 R5 R7 
;PRINTS DIGITS
ADD R0 R5 #0
OUT
ADD R0 R4 #0
OUT
ADD R0 R3 #0
OUT
ADD R0 R2 #0
OUT
BR FINISH_PRINT


NoALAFIM
ADD R4 R4 #0
BRz NoMAOT

;MAKE ASCII

ADD R2 R2 R7
ADD R3 R3 R7
ADD R4 R4 R7

;PRINT
ADD R0 R4 #0
OUT
ADD R0 R3 #0
OUT
ADD R0 R2 #0
OUT
BR FINISH_PRINT

NoMAOT
ADD R3 R3 #0
BRz NoASAAROT

;MAKE ASCII

ADD R2 R2 R7
ADD R3 R3 R7

;PRINT
ADD R0 R3 #0
OUT
ADD R0 R2 #0
OUT
BR FINISH_PRINT

NoASAAROT
ADD R2 R2 R7
ADD R0 R2 #0
OUT
BR FINISH_PRINT

FINISH_PRINT
;RETURN REGISTERS

LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6

LD R0 VALUE_R0

RET

HALT
ASCII_0 .FILL #48
ASCII_MINUS_PRINT .FILL #45
VALUE_R0 .FILL #0


;--------------------------- end print num function


;--------------------------- print board function
PrintBoard 
;GETS: array that every cell is either a number or -1

;CALLE SAVE

ADD R6, R6,#-6
STR R1,R6,#5
STR R2,R6,#4
STR R3,R6,#3
STR R4,R6,#2
STR R5,R6,#1
STR R7,R6,#0

LDR R1, R6, #8 ; R1 = start of array
LDR R2, R6, #7 ; R2 = number of lines in board

;main function code

lineLoop

LDR R3, R6, #6 ; R3 = number of colomes in board

columnLoop

LDR R4, R1, #0 ; R4 = current element


ADD R4, R4, #1
BRnp printCurrentNum ;if (R4 != 0) break;

LEA R0, x_val
PUTS

BR finishPrintX

printCurrentNum
ADD R4, R4, #-1 ; R4 = R4 - 1

;print num

ADD R6, R6, #-1
STR R4, R6 ,#0

JSR PrintNum

ADD R6,R6, #1


finishPrintX

;continue loop
ADD R1, R1 #1 ; R1 +=1

ADD R3,R3, #-1 ; R3 -=1
BRp columnLoop ; if (R3 < 0) : break

;print new line
AND R0,R0,#0
ADD R0,R0,#10
OUT

ADD R2, R2, #-1  ; R2 -=1
BRp lineLoop ; if(R2 < 0 ) : break;

;load registers 
LDR R1,R6,#5
LDR R2,R6,#4
LDR R3,R6,#3
LDR R4,R6,#2
LDR R5,R6,#1
LDR R7,R6,#0

ADD R6,R6,#6

RET


HALT
x_val .STRINGZ "x"

;-------------------------- end print board function


;-------------------------- nQueenSolver function

nQueenSolver

;CALLE SAVE

ADD R6, R6,#-6
STR R1,R6,#5
STR R2,R6,#4
STR R3,R6,#3
STR R4,R6,#2
STR R5,R6,#1
STR R7,R6,#0

;print to input number
LEA R0, pleaseEnterN
PUTS

;get number
JSR GetNum

;store number of queens
ST R0, numOfQueens

;print output
LEA R0, thisIsSolution
PUTS

;loud back R0
LD R0, numOfQueens


;reset array of positions to zero
ADD R1, R0 ,#0 ; R1 = R0
LEA R2, positions

resetArrLoop
AND R3, R3, #0 ; R3 = 0
STR R3, R2, #0

ADD R2, R2, #1
ADD R1,R1, #-1
BRp resetArrLoop
;end reset positions


;solve board with size N
ADD R6, R6, #-1

AND R0,R0,#0 ; R0 = 0
STR R0, R6,#0 ; k = 0

JSR solve

ADD R6, R6, #1


;load registers 
LDR R1,R6,#5
LDR R2,R6,#4
LDR R3,R6,#3
LDR R4,R6,#2
LDR R5,R6,#1
LDR R7,R6,#0

ADD R6,R6,#6

RET


HALT
pleaseEnterN .STRINGZ "please enter N \n "
thisIsSolution .STRINGZ "\n this is the solution: \n"


;-------------------------- end nQueenSolver function


;-------------------------- begin effecient dev
EfficientDivFunc

;MY WAT TO SLOVE THIS IS -
;FIRST WILL MAKE AN ARREY OF 2 PLACES AND PUT THE ADRESS IN R0 
;THEN I WILL PUT THE 2 ANSWERS IN THIS WAY IN THE ARREY
;THEN I WILL FINISH AND RETURN R0	


;CALLEE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0


;LOAD TWO ARGUMENTS AND DOES R0\R1.

LDR R0 R6 #6		;R0=M	
LDR R1 R6 #7		;R1=N	

;THE FUNCTION

ADD R0 R0 #0
BRz ZERO_DIV_R0
BRn NEG_DIV

ADD R1 R1 #0
BRz ZERO_DIV_R1
BRn NEG_DIV
BR CONT

ZERO_DIV_R0
AND R2 R2 #0
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER 0 TO BOTH ANSWERS
BR FINISH_DIV1

ZERO_DIV_R1
AND R2 R2 #0
ADD R2 R2 #-1
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER -1 TO BOTH ANSWERS
BR FINISH_DIV1

NEG_DIV
AND R2 R2 #0
ADD R2 R2 #-1
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER -1 TO BOTH ANSWERS
BR FINISH_DIV1


;R0=M,T1 , R1=N,T2 , R2=DIV , R3=RES ,R3=T3 ,R7=-N,-M,N
;ENTER THE N,M MINUS TO A LABEL AND USE R0,R1 FOR THE FUNCTION

CONT
ADD R3 R0 #0
AND R2 R2 #0

ST R1 JUST_N

NOT R7 R1
ADD R7 R7 #1
ST R7 MINUS_N

NOT R7 R0
ADD R7 R7 #0
ST R7 MINUS_M

LOOP_DIV

LD R7 MINUS_N
ADD R7 R3 R7
BRn FINISH_DIV

AND R0 R0 #0		;T1=1
ADD R0 R0 #1
LD R7 JUST_N		;T2=N
ADD R1 R7 #0
ADD R4 R1 R1		;T3=N<<1

WHILE
NOT R7 R3
ADD R7 R7 #1
ADD R7 R7 R4
BRzp CONT_LOOP_DIV	;T3<RES?
ADD R0 R0 R0		;T1<<=1
ADD R1 R1 R1		;T2<<=1
ADD R4 R4 R4		;T3<<=1
BR WHILE

CONT_LOOP_DIV
ADD R2 R2 R0		;DIV+=T1
NOT R7 R1
ADD R7 R7 #1
ADD R3 R7 R3		;RES-=T2
BR LOOP_DIV

FINISH_DIV

;R2=DIV,R3=RES.
;ENTER THE ANSWERS TO ARREY-
;UP-RES
;DOWN-DIV

LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0		;R2-DIV IS UPPER
STR R3 R0 #1		;R3-RES IS LOWER

FINISH_DIV1

;LOAD

;RETURN REGISTERS
LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6

RET



HALT
MINUS_N .FILL #0
MINUS_M .FILL #0
JUST_N .FILL #0
ARREY .BLKW #2

;-------------------------- end effecient dev


;--------------------------- mul function
;gets two numbers and multiplies them
Mul

;ADD R6, R6, #-<frame size>
ADD R6, R6, #-6 ;Make space for our local vars (R7, R1, R2, R3, R4,)

STR R1, R6, #0 ; saving R1
STR R2, R6, #1 ; saving R2
STR R7, R6, #2 ; saving R7
STR R3, R6, #3 ; saving R3
STR R4, R6, #4 ; saving R4
STR R5, R6, #5 ; saving R5


LDR R0,R6,#6 ; first argument into R0
LDR R1,R6,#7 ; second argument into R1


AND R2,R2,#0 	; reset r2

ADD R0,R0,#0 	; check if first num equal 0
BRz ENDMUL	; if R0 = 0, we return 0

ADD R1,R1,#0 	; check if second num equal 0
BRz ENDMUL	; if R1 = 0, we return 0

ADD R0,R0,#0 	; add to change cc
BRp AFTERNEG1	; if first num positive, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDMUL 
AFTERNEG1

ADD R1,R1,#0 	; add to change cc
BRp AFTERNEG2	; if second num positive, we can proceed

ADD R2,R2,#-1   ; if negative return -1 in sum
BR ENDMUL 
AFTERNEG2

ADD R2,R2,#1
AND R4,R4,#0    ; reset r4, will be index i of the for loop

FORLOOP

ADD R5,R4,#-16  ; for condition i<16
BRz ENDMUL      ; if i=16 exit the loop

ADD R2,R2,R2    ; c = c + c

ADD R0,R0,#0    ; add to change cc
BRzp AFTERCHECK ; if a >= 0 don't get into the if condition
ADD R2,R2,R1    ; if a < 0: c = c + b

AFTERCHECK

ADD R0,R0,R0    ; a = a + a
ADD R4,R4,#1    ; i++

BR FORLOOP

ENDMUL

ADD R0,R2,#0 		; R0 = return value (was in R2)

;restoring back the original values for the registers
;LDR Rx, R6, #y

LDR R1, R6, #0 ; loading R1
LDR R2, R6, #1 ; loading R2
LDR R7, R6, #2 ; loading R7
LDR R3, R6, #3 ; loading R3
LDR R4, R6, #4 ; loading R4
LDR R5, R6, #5 ; loading R5

;popping the stack frame
;ADD R6, R6, #<frame size>
ADD R6, R6, #6 ; restoring R6 pointer

RET
;--------------------------- end mul function


;----------------- main board data
HALT
positions .BLKW #36
numOfQueens .FILL #0
;---------------- end main board data


;-------------------------- solve function
;receives how much queens to solve -> k
solve
;CALLE SAVE

ADD R6, R6,#-6
STR R1,R6,#5
STR R2,R6,#4
STR R3,R6,#3
STR R4,R6,#2
STR R5,R6,#1
STR R7,R6,#0


;load k
LDR R2, R6, #6 ; R2 = k = number of queens to solve


;if K == N

LD R3, numOfQueens
; R3 = -R3
NOT R3, R3
ADD R3, R3, #1

ADD R3, R2, R3 ; R3 += R2 = R3 - R2

BRnp elseKNotN
;{

;print solution
JSR printSolution


BR finishFunction
;}


;else

elseKNotN
;{

LD R3, numOfQueens ; R3 = N = number of queens
AND R4,R4, #0 ; R4 = i = 0
loopOnOptions


STR R2, R6, #-1 ; k
STR R4, R6, #-2 ; i
ADD R6,R6,#-2

JSR isSafe

ADD R6,R6,#2

;0 = false , 1 = true

ADD R0,R0,#0 ;R0 = 0
BRz notSafe
;if is safe


; position[k] = i
LEA R5, positions
ADD R5, R5, R2

STR R4, R5, #0

;R5 = R5 - R2

;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

ADD R5, R5, R2

;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

;R5 = R5 - R2


;solve(k+1)
ADD R6, R6, #-1

ADD R5, R2, #1 ; R5 = R2 + 1 = k+1
STR R5, R6,#0 ; store k+1

JSR solve

ADD R6, R6, #1


notSafe

ADD R4,R4,#1 ; R4 +=1
ADD R3,R3, #-1 ; R3 -=1
BRp loopOnOptions


;}


finishFunction

;load registers 
LDR R1,R6,#5
LDR R2,R6,#4
LDR R3,R6,#3
LDR R4,R6,#2
LDR R5,R6,#1
LDR R7,R6,#0

ADD R6,R6,#6

RET

;-------------------------- end solve function



;-------------------------- isSafe function
;receives: queen_number : -2, row_position : -1
;checks if current boar is safe for all queens
isSafe

;CALLE SAVE

ADD R6, R6,#-6
STR R1,R6,#5
STR R2,R6,#4
STR R3,R6,#3
STR R4,R6,#2
STR R5,R6,#1
STR R7,R6,#0


;load parameters
LDR R2, R6, #6 ; R2 = row position
LDR R3, R6, #7 ; R3 = queen number


;check each queen before this one
AND R4, R4, #0 ; R4 = i  =0

loopOnQueens

; R5 = position[i] = other_row_pos
LEA R5, positions
ADD R0,R5,R4
LDR R5, R0, #0 


;other_row_pos == row_position
;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

ADD R5, R5, R2
BRnp firstConditionFalse

AND R0,R0,#0 ; R0 = 0
BR finishLoop




firstConditionFalse

;other_row_pos == row_position - (queen_number - i)

; R5 = position[i] = other_row_pos
LEA R5, positions
ADD R0,R5,R4
LDR R5, R0, #0 

;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

;R5 = R5 + R2
ADD R5, R5, R2

ADD R5, R5, R3 ; R5 += R3(queen_number - i)

BRnp secondConditionFalse

AND R0,R0,#0 ; R0 = 0
BR finishLoop


secondConditionFalse
;other_row_pos == row_position + (queen_number - i)

; R5 = position[i] = other_row_pos
LEA R5, positions
ADD R0, R5,R4
LDR R5, R0, #0 

;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

;R5 = R5 + R2
ADD R5, R5, R2

;R5 = -R5
NOT R5, R5
ADD R5, R5, #1

ADD R5, R5, R3 ; R5 += R3(queen_number - i)

BRnp thirdConditionFalse

AND R0,R0,#0 ; R0 = 0
BR finishLoop


thirdConditionFalse


ADD R4,R4,#1 ; R4 +=1 ; i +=1
ADD R3, R3, #-1 ; R3 -=1
BRp loopOnQueens



;R0 = 1
AND R0,R0,#0
ADD R0,R0,#1

finishLoop
;load registers 
LDR R1,R6,#5
LDR R2,R6,#4
LDR R3,R6,#3
LDR R4,R6,#2
LDR R5,R6,#1
LDR R7,R6,#0

ADD R6,R6,#6


RET


;-------------------------end isSafe function



;-------------------------print solution
;receives array that each cells represents where the queen is in the row
;prints in table the solution

printSolution

;CALLE SAVE

ADD R6, R6,#-6
STR R1,R6,#5
STR R2,R6,#4
STR R3,R6,#3
STR R4,R6,#2
STR R5,R6,#1
STR R7,R6,#0


;load game size
LEA R1, gameBoard
LD R2, numOfQueens ; R2 = numOfQueens


;reset array of positions to -1

;get table size = num of queens * num of queens
STR R2,R6,#-1	
STR R2,R6,#-2		
ADD R6,R6,#-2		

JSR Mul		

ADD R6,R6,#2
;end get table size = num of queens * num of queens


ADD R4, R0, #0 ; R4 = R0 = table size


resetToMinusOneArrLoop
AND R3, R3, #0 ; R3 = 0
ADD R3,R3,#-1 ; R3 = -1
STR R3, R1, #0

ADD R1, R1, #1
ADD R4,R4, #-1
BRp resetToMinusOneArrLoop

;end reset positions


;R1 = gameBoard
LEA R1, gameBoard

;add numbers in new array
AND R3,R3,#0 ; R3 = 0
LEA R4, positions
AND R5,R5,#0 ; R5 = 0


addNumbersLoop

;check if i < numOfQueens
ADD R7, R5,#0

;R7 = -R7
NOT R7, R7
ADD R7, R7, #1

ADD R7, R7, R2
BRz AddNumbersFinishLoop


;mainLoop
;where to store th queen
LDR R7, R4, #0
ADD R7, R7, R3

ADD R0, R1,R7

ADD R5,R5, #1 ; R5 +=1
STR R5, R0, #0 ; store current queen 
ADD R5,R5, #-1 ; R5 -=1


ADD R4,R4, #1
ADD R3,R3,R2
ADD R5,R5,#1
BR addNumbersLoop



AddNumbersFinishLoop
LDR R7,R6,#0



;call print

STR R1, R6, #0 ; store game board
STR R2, R6, #-1 ; store N
STR R2, R6, #-2 ; store N

ADD R6, R6, #-2

JSR PrintBoard

ADD R6,R6,#2
;end print



;load registers 
LDR R1,R6,#5
LDR R2,R6,#4
LDR R3,R6,#3
LDR R4,R6,#2
LDR R5,R6,#1
LDR R7,R6,#0

ADD R6,R6,#6

RET


HALT
gameBoard .BLKW #1296
gameBoardSize .FILL #1296
;-------------------------end print solution




.END


