 PRESERVE8 
	 THUMB
	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
				;e^x = 1 + x + x^2/2! + x^3/3! + .......
	
	VLDR.F32 s0,=6	;s0 gives the values of the exponent in e^x, i.e. x value
	VLDR.F32 s1,=1	;s1 stores the value of the whole expansion until a certain no. of terms
	VLDR.F32 s2,=1	;s2 stores the numerator of each term
	VLDR.F32 s3,=1	;s3 stores the denominator of each term
	VLDR.F32 s4,=0	;s4 stores the fraction value of each term 
	
	MOV r1,#3		;r1 gives the no. of terms in series that are to be considered
	MOV r2,#0	;r2 used to run the loop required no. of times
	
LOOP 

	VMUL.F32 s2,s2,s0	
	VDIV.F32 s4,s2,s3	
	VADD.F32 s1,s1,s4	
	ADD r2,r2,#1
	VMOV.F32 s6,r2
	VMUL.F32 s3,s3,s6	
	CMP r1,r2	;Loop runs 10 times i.e. e^x value is calculated until 10 terms i.e. 1 +x +x^2/2! +x^3/3! +x^4/4! +x^5/5! +x^6/6! +x^7/7! +x^8/8! +x^9/9!
	BNE LOOP	
	
stop B stop ; stop program
     ENDFUNC
     END