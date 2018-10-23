 PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
	
	MOV r1,#2	; r1, r2, r2 store the numbers of which largest is to be found
	MOV r2,#16
	MOV r3,#14
	MOV r4,#0	;r4 is used to store the largest no. among the three
	
	CMP r1, r2
	BLT LOOP1
	CMP r1,r3
	BLT LOOP2
	MOV r4, r1
	B stop
LOOP1 CMP r2, r3
	BLT LOOP2
	MOV r4, r2
	B stop
LOOP2 MOV r4, r3

stop B stop ; stop program
     ENDFUNC
     END