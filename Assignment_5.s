     AREA     appcode, CODE, READONLY
     EXPORT __main
	 IMPORT	printMsg
	 ENTRY 
__main  FUNCTION	
			  VLDR.F32 S12, =1 ; input X0
			  VLDR.F32 S13, =1 ; input X1
			  VLDR.F32 S14, =1 ; input X2
			  ADR.W r2, Branch_Table
			  MOV r1, #1
			  TBB [r2 , r1]


NAND_LOGIC	   VLDR.F32 s15 ,=0.6 	;W1   
		       VLDR.F32 s16 ,=-0.8  ;W2   
               VLDR.F32	s17 ,=-0.8 	;W3
               VLDR.F32 s18 ,=0.3   ;BIAS   
			   B LOOP1
			   
			  
NOR_LOGIC	   VLDR.F32 s15 ,=0.5	;W1   
		       VLDR.F32 s16 ,=-0.7  ;W2   
               VLDR.F32	s17 ,=-0.7 	;W3
               VLDR.F32 s18 ,=0.1   ;BIAS   
			   B LOOP1
			   
			   
AND_LOGIC	   VLDR.F32 s15 ,=-0.1 	;W1   
		       VLDR.F32 s16 ,=0.2   ;W2   
               VLDR.F32	s17 ,=0.2 	;W3
               VLDR.F32 s18 ,=-0.2  ;BIAS   
			   B LOOP1


OR_LOGIC	   VLDR.F32 s15 ,=-0.1 	;W1   
		       VLDR.F32 s16 ,=0.7   ;W2   
               VLDR.F32	s17 ,=0.8 	;W3
               VLDR.F32 s18 ,=-0.1  ;BIAS   
			   B LOOP1
			   
			   
XOR_LOGIC	   VLDR.F32 s15 ,=-5	;W1   
		       VLDR.F32 s16 ,=20    ;W2   
               VLDR.F32	s17 ,=10 	;W3
               VLDR.F32 s18 ,=-1    ;BIAS   
			   B LOOP1
			   
			   
NOT_LOGIC	   VLDR.F32 s15 ,=0.5 	;W1   
		       VLDR.F32 s16 ,=-0.7  ;W2   
               VLDR.F32	s17 ,=0 	;W3
               VLDR.F32 s18 ,=0.1   ;BIAS   
			   B LOOP1
			   
			   
Branch_Table		  
    DCB   0		  
    DCB   ((NOR_LOGIC-NAND_LOGIC)/2)	
	DCB   ((AND_LOGIC-NAND_LOGIC)/2)	
	DCB   ((OR_LOGIC-NAND_LOGIC)/2)
	DCB   ((XOR_LOGIC-NAND_LOGIC)/2)
	;DCB   ((XNOR_LOGIC-NAND_LOGIC)/2)
    DCB ((NOT_LOGIC-NAND_LOGIC)/2)


LOOP1		   VMUL.F32 S19, S12, S15 ; W1*X0
			   VADD.F32 S20, S20, S19 ; ADDING AND STORING IN S20 WHICH IS GIVEN TO THE SIGMOID
			   VMUL.F32 S19, S13, S16 ; W2*X1
			   VADD.F32 S20, S20, S19
			   VMUL.F32 S19, S14, S17 ; W3*X2
			   VADD.F32 S20, S20, S19
			   
			   B SIGMOID




			  VMOV.F32 S0, S20   ;exponent for e
			  VMOV.F32 S7, #1          
			  VMOV.F32 S9, #26	 ;Number of terms
			  VMOV.F32 S1, #1.0  ;temp
			  VMOV.F32 S2, #1.0  ;final sum
			  VMOV.F32 S8, #1.0
			  VMOV.F32 S11,#1.0
			  
LOOP	VCMP.F32 S7, S9
		VMRS.F32 APSR_nzcv, FPSCR  ; to copy flag values fpsr to apsr 
		BGT SIGMOID
		VDIV.F32 S3, S0, S7
		VMUL.F32 S1, S1, S3       ;temp = temp *(number)/1
		VADD.F32 S2, S2, S1		  ; sum = sum+temp
		VADD.F32 S7, S7, S8       ; increment 
		B LOOP
		;B SIGMOID
		
SIGMOID VADD.F32 S10, S2, S11
		VDIV.F32 S10, S2, S10
		B LOOP_F


LOOP_F      VLDR.F32 S21 , =0.5
			    VCMP.F32     S10 , S21  ; comparing with 0.5, if greater then final output is '1' else '0'
			    VMRS.F32 APSR_nzcv , FPSCR                    
				ITE  HI
				MOVHI r0 , #0
				MOVLS r0 , #1
			BL printMsg

				
STOP		      B STOP  ; stop program

     ENDFUNC
     END