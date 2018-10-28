  PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
				;e^x = 1 + x + x^2/2! + x^3/3! + .......
	MOV r1,#100	;r1 gives the no. of terms in series that are to be considered
	MOV r2,#6	;r2 gives the values of the exponent in e^x, i.e. x value
	MOV r3,#1	;r3 stores the value of the whole expansion until a certain no. of terms
	MOV r4,#1	;r4 stores the numerator of each term
	MOV r5,#1	;r5 stores the denominator of each term
	MOV r6,#0	;r6 stores the fraction value of each term 
	MOV r7,#1	;r7 used to run the loop required no. of times
	
	
LOOP 

	MUL r4,r4,r2
	UDIV r6,r4,r5
	ADD r3,r3,r6
	ADD r7,r7,#1
	MUL r5,r5,r7

	CMP r7,r1	;Loop runs 10 times i.e. e^x value is calculated until 10 terms i.e. 1 +x +x^2/2! +x^3/3! +x^4/4! +x^5/5! +x^6/6! +x^7/7! +x^8/8! +x^9/9!
	BNE LOOP	
	
stop B stop ; stop program
     ENDFUNC
     END