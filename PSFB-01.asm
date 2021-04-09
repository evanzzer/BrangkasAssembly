DATAPTR EQU 400H

ORG 00H
	MOV P2, #0FFH
	MOV P3, #0FFH
	MOV DPTR, #DATAPTR
	
INIT:	MOV P3, #0FFH
	MOV R0, #04H

CHECK:	SETB P2.0
	CLR P2.3
	SJMP ROW1
CHECK2:	SETB P2.3
	CLR P2.2
	SJMP ROW2
CHECK3: SETB P2.2
	CLR P2.1
	SJMP ROW3
CHECK4: SETB P2.1
	CLR P2.0
	SJMP ROW4

ROW1:	JB P2.7, ROW1_2
	SETB P2.3
	MOV A, #01H
	LJMP LOOP
ROW1_2: JB P2.6, ROW1_3
	SETB P2.3
	MOV A, #02H
	LJMP LOOP
ROW1_3: JB P2.5, CHECK2
	SETB P2.3
	MOV A, #03H
	LJMP LOOP

ROW2:	JB P2.7, ROW2_2
	SETB P2.2
	MOV A, #04H
	LJMP LOOP
ROW2_2: JB P2.6, ROW2_3
	SETB P2.2
	MOV A, #05H
	LJMP LOOP
ROW2_3: JB P2.5, CHECK3
	SETB P2.2
	MOV A, #06H
	LJMP LOOP

ROW3:	JB P2.7, ROW3_2
	SETB P2.1
	MOV A, #07H
	LJMP LOOP
ROW3_2: JB P2.6, ROW3_3
	SETB P2.1
	MOV A, #08H
	LJMP LOOP
ROW3_3: JB P2.5, CHECK4
	SETB P2.1
	MOV A, #09H
	LJMP LOOP

ROW4:	JB P2.7, ROW4_2
	SETB P2.0
	MOV A, #0AH
	LJMP LOOP
ROW4_2: JB P2.6, ROW4_3
	SETB P2.0
	MOV A, #00H
	LJMP LOOP
ROW4_3: JB P2.5, BACK
	SETB P2.0
	MOV A, #0BH
	LJMP LOOP

BACK:	LJMP CHECK

LOOP:	MOV @R0, A
	DJNZ R0, BACK
	MOV R0, #04H
	SJMP VERIFY

ERRBACK:CLR P3.0
	ACALL DELAY
	LJMP INIT

VERIFY:	MOV A, R0
	DEC A
	MOVC A, @A+DPTR
	XRL A, @R0
	CJNE A, #00H, ERRBACK
	DJNZ R0, VERIFY
	
	CLR P3.1
	ACALL DELAY
	LJMP ENDING

DELAY:	MOV R3, #10H
DLOOP:	DJNZ R3, DLOOP
	RET

ORG 400H
PASS: 	DB 01H, 02H, 03H, 04H

ENDING: END

