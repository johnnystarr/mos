
BITS 16

org 100h



jmp START

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

START:		

			MOV		DL, 00000000b
			
			MOV		SI, STR
			CALL	MOS_IO_PRINT_STRING
			
			MOV		SI, STR2
			CALL	MOS_IO_PRINT_STRING
			
			RET
			

STR: 		DB "Hey you guys!", 0
STR2:		DB "This is awesome!", 0