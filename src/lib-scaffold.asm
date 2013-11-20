
BITS 16

org 100h

jmp START

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

START:			
			MOV		DL, 00000001b
			MOV		DI, STR
			CALL	MOS_IO_READ_STRING
			MOV		SI, STR
			CALL	MOS_IO_PRINT_STRING
			RET
STR: db 0
