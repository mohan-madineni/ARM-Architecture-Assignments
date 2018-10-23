 PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
	
	MOV r1,#24	; r1, r2 store the numbers for which GCD is to be calculated
	MOV r2,#16
	
LOOP CMP r1,r2	; Loop is executed until r1, r2 values are equal and that value is the GCD
	ITE LT
	SUBLT r2,r2,r1
    SUBGE r1,r1,r2
	CMP r1,r2
	BNE LOOP
stop B stop ; stop program
     ENDFUNC
     END