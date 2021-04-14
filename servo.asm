$NOMOD51
$INCLUDE (8051.MCU)
ORG 00H ;Start the program
MAIN:   MOV TMOD, #01H ;using Timer 0 in Mode 1
    LCALL ninety_degrees ;Function to move to position = 90 deg
    LCALL delay ;Function to create a delay of 1 sec

    LCALL one_eighty_degrees ;Function to move to position = 180 deg
    LCALL delay ;Function to create a delay of 1 sec

    SJMP MAIN ;to repeat the loop until manually stopped

ninety_degrees: ;To create a pulse of 1.5ms
    MOV TH0, #0FAH ;(FFFF - FA25 + 1)H = (05DB)H 
    MOV TL0, #25H ;equal to (1500)D = 1.5ms
    SETB P1.3 ;Make P1.3 HIGH
    SETB TR0 ;Start the timer 0
    JNB TF0, $ ;Wait till the TF0 flag is set 
    CLR P1.3 ;Make P1.3 LOW 
    CLR TF0 ;Clear the flag manually
    CLR TR0 ;Stop the timer 0
    RET 

one_eighty_degrees: ;To create a pulse of 2ms 
    MOV TH0, #0F8H ;(FFFF - F831 + 1)H = (07CF)H 
    MOV TL0, #31H ;equal to (2000)D = 2ms
    SETB P1.3 ;Make P1.3 HIGH
    SETB TR0 ;Start the timer 0
    JNB TF0, $ ;Wait till the TF0 flag is set
    CLR P1.3 ;Make P1.3 LOW 
    CLR TF0 ;Clear the flag manually
    CLR TR0 ;Stop the timer 0
    RET 

DELAY:	MOV R7, #2AH; DELAY FOR approx. 3s
TIMER:	MOV TMOD, #01H	; TIMER LOGIC
	SETB TR0
	JNB TF0, $
	CLR TR0
	CLR TF0
	DJNZ R7, TIMER
	RET

END