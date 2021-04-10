;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Fri Apr 9 2021
; Processor: AT89C51
; Compiler:  ASEM-51 (Proteus)
;====================================================================

$NOMOD51
$INCLUDE (8051.MCU)


DATAPTR EQU 400H
PRESSED BIT 0H

ORG 00H
	MOV P2, #0FFH
	MOV P1, #0F9H
	MOV P3, #0FFH
	MOV DPTR, #DATAPTR
	
INIT:	MOV P2, #0FFH
	MOV P1, #0F9H
	MOV R0, #04H

CHECK:	MOV A, #01H
	MOV P2, #0FEH
	ACALL COLCHK

	JB PRESSED, STORE

	MOV A, #04H
	MOV P2, #0FDH
	ACALL COLCHK

	JB PRESSED, STORE

	MOV A, #07H
	MOV P2, #0FBH
	ACALL COLCHK

	JB PRESSED, STORE

	MOV A, #00H
	MOV P2, #0F7H
	ACALL COLZERO

	JB PRESSED, STORE

	JMP CHECK

COLCHK:	CLR PRESSED

	JB P2.4, COL_2
	JNB P2.4, $
	SETB PRESSED
	RET

COL_2:	JB P2.5, COL_3
	JNB P2.5, $
	INC A
	SETB PRESSED
	RET

COL_3:	JB P2.6, RETURN
	JNB P2.6, $
	INC A
	INC A
	SETB PRESSED
RETURN:	RET

COLZERO:JB P2.5, RETURN
	JNB P2.5, $
	SETB PRESSED
	RET

STORE:	MOV @R0, A
	DJNZ R0, BACK
	MOV R0, #04H
	SJMP VERIFY
	
BACK:	ACALL SLEEP
	LJMP CHECK

VERIFY:	MOV A, R0
	DEC A
	MOVC A, @A+DPTR
	XRL A, @R0
	MOV R6, A
	CJNE R6, #00H, ERRBACK
	DJNZ R0, VERIFY
	
	SETB P1.2
	ACALL DELAY
	LJMP INIT
	
ERRBACK:SETB P1.1
	ACALL DELAY
	LJMP INIT

SLEEP:  MOV R7, #01H
	 SJMP TIMER
DELAY:	MOV R7, #2AH
TIMER:	MOV TMOD, #01H
	SETB TR0
DLOOP:	JNB TF0, DLOOP
	CLR TR0
	CLR TF0
	DJNZ R7, TIMER
	RET

ORG 400H
PASS: 	DB 01H, 02H, 03H, 04H

END
