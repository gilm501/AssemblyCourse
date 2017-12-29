.ORIG X3000

LEA R6 STACK
LD R1 STACK_SIZE
ADD R6 R6 R1


JSR SimpleMathQuiz



HALT

;MAIN
STACK .BLKW #40
STACK_SIZE .FILL #-40
result .fill #1062


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;BEGINING OF SIMPLE MATH QUIZ FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;SimpleMathQuiz

FIRST_NUMBER_SENTENCE .STRINGZ "ENTER THE FIRST NUMBER: "
SECOND_NUMBER_SENTENCE .STRINGZ "ENTER THE SECOND NUMBER: "
ASCII_MUL .FILL #42
ASCII_HILUK .FILL #47
ASCII_HEZKA .FILL #94
ASCII_PLUS .FILL #43
ASCII_MINUS .FILL #45
FIRST_PART_FINISH_SENTENCE .STRINGZ "You have answered "
SECOND_PART_FINISH_SENTENCE .STRINGZ " correct answers out of 5 questions "


SimpleMathQuiz:			;THE PROGRAM
	
;CALLE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0

;GETS THE TWO NUMBERS FOR THE GAME-


;GETS THE FIRST NUMBER AND PUT IT IN R1;

LEA R0 FIRST_NUMBER_SENTENCE
PUTS				;PRINTS ENTER THE FIRST NUMBER

AND R0 R0 #0
ADD R0 R0 #10
OUT
				;GO LINE DOWN
JSR GetNum			;GETS A NUMBER
AND R1 R1 #0			
ADD R1 R0 #0			;R1-FIRST NUMBER


AND R0 R0 #0
ADD R0 R0 #10
OUT				;GO LINE DOWN


;GETS THE SECOND NUMBER AND PUT IT IN R2;

LEA R0 SECOND_NUMBER_SENTENCE
PUTS				;PRINTS "ENTER THE SECOND NUMBER
AND R0 R0 #0
ADD R0 R0 #10
OUT				;GO LINE DOWN
JSR GetNum			;GETS A NUMBER
ADD R2 R0 #0			;R2-SECOND NUMBER




AND R0 R0 #0
ADD R0 R0 #10
OUT				;GO LINE DOWN


;NOW- ;R1=FIRNT NUMBER;R2=SECOND NUMBER;
;MAKE THE CALLS TO THE PRINT FUNK
;R4 WILL REMEMBER THE NUMBER OF TIMES THERE WERE A RIGHT NUMBER

;CALL THE MUL FUNK (*)

LD R3 ASCII_MUL
STR R1 R6 #-1		;LOWEST IS NUMBER 1
STR R3 R6 #-2		;HIGHR IS THE FUNK (*)	
STR R2 R6 #-3		;HIGHEST IS NUMBER 2
ADD R6 R6 #-3
JSR PRINT		;PRINTS THE GAME FOR (*)

ADD R4 R0 #0			;IF THE ANSEWR IS CORRECT R0=1 ELSE R0=0 ;R4 COUNTS NUMBER OF RIGHT ANSWERS

ADD R6 R6 #3			;MAKE R6 POINT TO STACK WITHOUT WHAT WE ENTERED



;CALL THE EXP FUNK (^)

LD R3 ASCII_HEZKA
STR R1 R6 #-1
STR R3 R6 #-2
STR R2 R6 #-3
ADD R6 R6 #-3
JSR PRINT		;PRINTS THE GAME FOR (^)

ADD R4 R0 R4			;IF THE ANSEWR IS CORRECT R0=1 ELSE R0=0 ;R4 COUNTS NUMBER OF RIGHT ANSWERS
ADD R6 R6 #3



;CALL THE DIV FUNK (/)

LD R3 ASCII_HILUK
STR R1 R6 #-1
STR R3 R6 #-2
STR R2 R6 #-3
ADD R6 R6 #-3
JSR PRINT		;PRINTS THE GAME FOR (/)

ADD R4 R0 R4			;IF THE ANSEWR IS CORRECT R0=1 ELSE R0=0 ;R4 COUNTS NUMBER OF RIGHT ANSWERS
ADD R6 R6 #3



;CALL THE PLUS FUNK (+)

LD R3 ASCII_PLUS
STR R1 R6 #-1
STR R3 R6 #-2
STR R2 R6 #-3
ADD R6 R6 #-3
JSR PRINT		;PRINTS THE GAME FOR (+)

ADD R4 R0 R4			;IF THE ANSEWR IS CORRECT R0=1 ELSE R0=0 ;R4 COUNTS NUMBER OF RIGHT ANSWERS
ADD R6 R6 #3


;CALL THE MINUS FUNK (-)

LD R3 ASCII_MINUS
STR R1 R6 #-1
STR R3 R6 #-2
STR R2 R6 #-3
ADD R6 R6 #-3
JSR PRINT		;PRINTS THE GAME FOR (-)
ADD R4 R0 R4			;IF THE ANSEWR IS CORRECT R0=1 ELSE R0=0 ;R4 COUNTS NUMBER OF RIGHT ANSWERS
ADD R6 R6 #3


;PRINTS THE FINISH LINE

LEA R0 FIRST_PART_FINISH_SENTENCE	;PRINTS - YOU HAVE ANSERED 
PUTS
LD R1 ASCII_0				;R1=ASCCI_0
ADD R0 R4 R1				;R0=R4+R1	;R0=NUMBER OF RIGHT ANSWERES+ASCII_0	;R0=ASCII OF THE NUMBER OF RIGHT ANSERES
OUT				;PRINTS THE NUMBER OF RIGHT ANSERS
LEA R0 SECOND_PART_FINISH_SENTENCE	;PRINTS - correct answers out of 5 questions
PUTS

;LOAD THE ARGUMENTS

LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;END OF SIMPLE MATH QUIZ FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF PRINT FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;PRINT
 MINUS_ASCII_0 .FILL #-48
MINUS_ASCII_MUL .FILL #-42
MINUS_ASCII_HILUK .FILL #-47
MINUS_ASCII_HEZKA .FILL #-94
MINUS_ASCII_PLUS .FILL #-43
MINUS_ASCII_MINUS .FILL #-45
ASCII_a	.FILL #97
ASCII_b .FILL #98
ASCII_c	.FILL #99
ASCII_POINT .FILL #46
BAD_ANSWER_STRING .STRINGZ "Error – the correct answer is: "
GOOD_ANSWER_STRING .STRINGZ "Correct Answer :) " 


PRINT:


;CALLE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0

;LOAD ARGUMENTS

LDR R1 R6 #8	;R1-FIRST NUM	
LDR R2 R6 #7	;R2-FUNCTION	
LDR R3 R6 #6	;R3-SECOND NUM


;CHECK THE FUNCTION NEEDED AND GO TO THE RIGHT LABEL OF IT

LD R4 MINUS_ASCII_MUL 		;CHECK IF KEFEL
ADD R4 R2 R4
BRz MUL_LABEL

LD R4 MINUS_ASCII_HEZKA 	;CHECK IF HEZKA
ADD R4 R2 R4
BRz HEZKA_LABEL	

LD R4 MINUS_ASCII_HILUK 	;CHECK IF HILUK
ADD R4 R2 R4
BRz HILUK_LABEL			

LD R4 MINUS_ASCII_PLUS 		;CHECK IF PLUS
ADD R4 R2 R4
BRz PLUS_LABEL	

LD R4 MINUS_ASCII_MINUS 	;CHECK IF MINUS
ADD R4 R2 R4
BRz MINUS_LABEL	


;THE FUNCTION LABELS-

MUL_LABEL:		;GETS THE ANSWER TO THE MUL

;STORE THE VALUES IN STACK
STR R1 R6 #-1			
STR R3 R6 #-2
ADD R6 R6 #-2
JSR MUL_FUNK	;GET THE ANSWER OF THE MUL

ADD R5 R0 #0	;ANSWER IS IN R5
ADD R6 R6 #2		
BR PRINT_THE_QUESTION	


HEZKA_LABEL:		;GETS THE ANSWER TO THE HEZKA

;STORE THE VALUES IN STACK
STR R1 R6 #-2
STR R3 R6 #-1
ADD R6 R6 #-2
JSR EfficientExp
ADD R5 R0 #0		;ANSWER IS IN R5
ADD R6 R6 #2		
BR PRINT_THE_QUESTION


HILUK_LABEL:		;GETS THE ANSWER TO THE HILUK

;STORE THE VALUES IN STACK
STR R1 R6 #-2
STR R3 R6 #-1
ADD R6 R6 #-2
JSR EfficientDivFunc

LDR R5 R0 #0		;ANSWER IS IN R5
ADD R6 R6 #2		
BR PRINT_THE_QUESTION



PLUS_LABEL:

ADD R5 R1 R3		;ANSWER IS IN R5
BR PRINT_THE_QUESTION


MINUS_LABEL:
NOT R5 R3
ADD R5 R5 #1
ADD R5 R1 R5		;ANSWER IS IN R5
BR PRINT_THE_QUESTION



;PRINTS THE QUESTION - NUM @ NUM ; @ IS THE FUNCTION


PRINT_THE_QUESTION:

;PRINTS THE FIRST NUMBER
STR R1 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1

;PRINTS THE FUNCTION BETWEEN
ADD R0 R2 #0
OUT 
;PRINTS THE SECOND FUNCTION
STR R3 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1

ADD R1 R5 #0		;R1 HOLDS THE RIGHT ANSWER


;PRINTS THE OPTIONS THIS WAY-
;a. ans++
;b. ans
;c. ans--

;GO DOWN A LINE
AND R5 R5 #0
ADD R5 R5 #10
ADD R0 R5 #0
OUT	
		
LD R0 ASCII_a
OUT			;PRINTS a

LD R0 ASCII_POINT
OUT			;PRINTS .

ADD R0 R1 #1
STR R0 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1		;PRINTS ANSWER++


;GO DOWN A LINE
ADD R0 R5 #0
OUT	

LD R0 ASCII_b
OUT			;PRINTS b

LD R0 ASCII_POINT
OUT			;PRINT .

ADD R0 R1 #0
STR R0 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1		;PRINTS THE RIGHT ANSWER


;GO DOWN A LINE
ADD R0 R5 #0
OUT		
LD R0 ASCII_c		
OUT			;PRINTS C
LD R0 ASCII_POINT
OUT			;PRINTS .
ADD R0 R1 #-1
STR R0 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1		;PRINTS ANSWER--


;GO DOWN A LINE
ADD R0 R5 #0
OUT		


;GETS THE GUESS OF THE PLAYER
GETC

;CHECK IF THE GUESS IS b

LD R5 ASCII_b
NOT R5 R5
ADD R5 R5 #1
ADD R5 R5 R0
BRz GOOD_ANSWER


;PRINTS THAT IT IS A WRONG ANS

LEA R0 BAD_ANSWER_STRING
PUTS			;PRINTS - Error – the correct answer is:
STR R1 R6 #-1
ADD R6 R6 #-1
JSR PrintNum		;PRINTS THE RIGHT ANSWER	
ADD R6 R6 #1

;go down two times
AND R5 R5 #0		
ADD R5 R5 #10
ADD R0 R5 #0
OUT 
OUT


AND R0 R0 #0		;RETURN VALUE 0 MEAN WRONG ANSWER

BR FINISH_FUNK

;PRINTS THAT IT IS A RIGHT ANS

GOOD_ANSWER:
LEA R0 GOOD_ANSWER_STRING
PUTS

;go down two times
AND R5 R5 #0		
ADD R5 R5 #10
ADD R0 R5 #0
OUT 
OUT

AND R0 R0 #0
ADD R0 R0 #1		;RETURN VALUE 1 MEAN WRONG ANSWER



FINISH_FUNK:



;LOAD

LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6

RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF PRINT  FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF PRINT NUM FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;PRINTNUM
ASCII_0 .FILL #48
ASCII_MINUS_PRINT .FILL #45
VALUE_R0 .FILL #0

PrintNum:

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

CONT_PRINT_NUM:

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


NoASAROTALAFIM:
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


NoALAFIM:
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

NoMAOT:
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

NoASAAROT:
ADD R2 R2 R7
ADD R0 R2 #0
OUT
BR FINISH_PRINT

FINISH_PRINT:
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF PRINT NUM FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF GET NUM FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;GETNUM
ASCII_MINUS_0 .FILL #-48

GetNum:

;CALLE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0
AND R2 R2 #0


LOOP_PRINT:

GETC
;R0 <-- ASCII OF A LETTER
LD R1  ASCII_MINUS_0		;R1=-48

ADD R0 R0 R1		;MAKE R0 BE THE LETTER, IF ITS NEGETIVE THAT MEAN THAT WE GOT ASCII 10 AND THE WE FINISH.
BRn FINISH_NUM		;IF NEG FINISH.
ADD R3 R0 #0		;R3 IS THE DIGIT
STR R2 R6 #-1		;ENTER R2 (LAST NUMBER) TO THE STACK
AND R5 R5 #0		
ADD R5 R5 #10		;R5=10
STR R5 R6 #-2		;ENTER R5(10) TO THE STACK
ADD R6 R6 #-2		;R6 POINT TO THE TOP OF THE STACK

JSR MUL_FUNK		;R0=R2*10

ADD R6 R6 #2
ADD R2 R0 R3		;R2=R0+R3=R2*10+R3=LAST_NUM*10+LAST_DIGIT
BR LOOP_PRINT		;RETURN TO LOOP


FINISH_NUM:

ADD R0 R2 #0
STR R0 R6 #-1
ADD R6 R6 #-1
JSR PrintNum
ADD R6 R6 #1

;ADD R0 R2 #0

;RETURN REGISTERS
LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6

RET




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF GET NUM FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF MUL FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;MUL
LOOP_NUM .FILL #-16


MUL_FUNK:



 
;CALLE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0

;LOAD THE ARGUMANTS
LDR R1 R6 #6
LDR R2 R6 #7

;check legal

ADD R1 R1 #0
BRz ZERO_MUL
BRn NEG_MUL
ADD R2 R2 #0
BRz ZERO_MUL
BRn NEG_MUL
BR CONT_MUL

ZERO_MUL:
AND R0 R0 #0
BR FINISH

NEG_MUL:
AND R0 R0 #0
ADD R0 R0 #-1
BR FINISH

;THE FUNCTION;
CONT_MUL

LD R4 LOOP_NUM
AND R3 R3 #0

;CHECK IF ZERO

ADD R1 R1 #0
BRz ZERO
ADD R2 R2 #0
BRz ZEROSEC
ADD R7 R2 #-1
BRz ONE
BR LOOP_MUL

ZERO:
AND R0 R0 #0
BR FINISH

ZEROSEC:
AND R0 R0 #0
ADD R0 R0 #1
BR FINISH

ONE:
ADD R0 R1 #0
BR FINISH

;THE LOOP OF THE MUL FUNK
LOOP_MUL:
ADD R5 R3 R4
BRZ FINISH
ADD R0 R0 R0
ADD R1 R1 #0
BRn IFOPS
ADD R1 R1 R1
ADD R3 R3 #1
BR LOOP_MUL

IFOPS:
ADD R0 R0 R2
ADD R1 R1 R1
ADD R3 R3 #1
BR LOOP_MUL


FINISH:

;RETURN REGISTERS
LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6

RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF MUL FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF EfficientDivFunc FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;DIV
MINUS_N .FILL #0
MINUS_M .FILL #0
JUST_N .FILL #0
ARREY .BLKW #2

EfficientDivFunc:


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

ZERO_DIV_R0:
AND R2 R2 #0
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER 0 TO BOTH ANSWERS
BR FINISH_DIV1

ZERO_DIV_R1:
AND R2 R2 #0
ADD R2 R2 #-1
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER -1 TO BOTH ANSWERS
BR FINISH_DIV1

NEG_DIV:
AND R2 R2 #0
ADD R2 R2 #-1
LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0	
STR R2 R0 #1		;ENTER -1 TO BOTH ANSWERS
BR FINISH_DIV1


;R0=M,T1 , R1=N,T2 , R2=DIV , R3=RES ,R3=T3 ,R7=-N,-M,N
;ENTER THE N,M MINUS TO A LABEL AND USE R0,R1 FOR THE FUNCTION

CONT:
ADD R3 R0 #0
AND R2 R2 #0

ST R1 JUST_N

NOT R7 R1
ADD R7 R7 #1
ST R7 MINUS_N

NOT R7 R0
ADD R7 R7 #0
ST R7 MINUS_M

LOOP_DIV:

LD R7 MINUS_N
ADD R7 R3 R7
BRn FINISH_DIV

AND R0 R0 #0		;T1=1
ADD R0 R0 #1
LD R7 JUST_N		;T2=N
ADD R1 R7 #0
ADD R4 R1 R1		;T3=N<<1

WHILE:
NOT R7 R3
ADD R7 R7 #1
ADD R7 R7 R4
BRzp CONT_LOOP_DIV	;T3<RES?
ADD R0 R0 R0		;T1<<=1
ADD R1 R1 R1		;T2<<=1
ADD R4 R4 R4		;T3<<=1
BR WHILE

CONT_LOOP_DIV:
ADD R2 R2 R0		;DIV+=T1
NOT R7 R1
ADD R7 R7 #1
ADD R3 R7 R3		;RES-=T2
BR LOOP_DIV

FINISH_DIV:

;R2=DIV,R3=RES.
;ENTER THE ANSWERS TO ARREY-
;UP-RES
;DOWN-DIV

LEA R0 ARREY		;LOADS THE ARREY
STR R2 R0 #0		;R2-DIV IS UPPER
STR R3 R0 #1		;R3-RES IS LOWER

FINISH_DIV1:

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF EfficientDivFunc FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;BEGINING OF Efficient EXP FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EfficientExp:

;THE STACK LOOKS LIKE-
;
;THE NUMBER <---R6
;THE HEZKA

;WE WANT TO DO R0^R1

;store value

;CALLEE SAVE
ADD R6 R6 #-6
STR R1 R6 #5
STR R2 R6 #4
STR R3 R6 #3
STR R4 R6 #2
STR R5 R6 #1
STR R7 R6 #0


LDR R0 R6 #6
LDR R1 R6 #7

;---check input part

;check if R0 is zero

ADD R0, R0, #0 ; R0 = R0

BRnp R0NotZero ; if (R0 == 0)
AND R2, R2, #0
BR endMultiLoop:

R0NotZero:

;check if one of the numbers is negative

ADD R0, R0, #0 ; R0 = R0
BRp r0NotNegative ;if (R0 < 0) {R2 = -1, end;}

AND R2,R2,#0 ; R2 = 0
ADD R2,R2,#-1 ;R2 = -1
BR endMultiLoop


r0NotNegative:
ADD R1, R1, #0 ; R1 = R1
BRp r1NotNegative ;if (R1 < 0) {R2 = -1, end;}
BRz r1IsZero
AND R2,R2,#0 ; R2 = 0
ADD R2,R2,#-1 ;R2 = -1
BR endMultiLoop

r1IsZero
AND R2,R2,#0 ; R2 = 0
ADD R2,R2,#1 ;R2 = 1
BR endMultiLoop

r1NotNegative:

;if reached here all the input is valid.
;start calculation

AND R2, R2, #0 ; R2 = 0 
ADD R2, R2, #1 ; R2 = 1
ADD R4 R0 #0 ;R4- NUM THAT WE MUL
ADD R3, R1, #0 ; R3 = R1 

multiplicationLoop:

ADD R3, R3, #0 ; R3 = R3
BRz endMultiLoop ;if(R3 != 0) : 

ADD R1, R2, #0 ; R1 = R2

STR R4 R6 #-1
STR R1 R6 #-2
ADD R6 R6 #-2
;perform multiplication

JSR MUL_FUNK
ADD R2 R0 #0
ADD R6 R6 #2

ADD R3, R3, #-1 ; R3 -= 1
BR multiplicationLoop ; continue loop

endMultiLoop:

;FINISH - RO=ANSWER AND LOAD REGISTERS


ADD R0 R2 #0

LDR R1 R6 #5
LDR R2 R6 #4
LDR R3 R6 #3
LDR R4 R6 #2
LDR R5 R6 #1
LDR R7 R6 #0
ADD R6 R6 #6



RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF Efficient EXP FUNK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.END