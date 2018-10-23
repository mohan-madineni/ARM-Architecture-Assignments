  PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
	
	MOV r1,#1
	MOV r2,#1
	MOV r3,#1	;R3 gives the next value in fibonacci series
	MOV r4,#0	;R4 is used to run the loop required no. of times
	
LOOP ADD r3,r1,r2
	MOV r1,r2
	MOV r2,r3
	ADD r4,r4,#1
	CMP r4,#5
	BNE LOOP	
	
stop B stop ; stop program
     ENDFUNC
     END