
BITS 16

org 100h

jmp START

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

START:		MOV		DH, 10
			MOV		DL, 00000000b
			MOV		DI, STR
			CALL	MOS_IO_READ_STRING
			MOV		SI, STR
			CALL	MOS_STRING_TOUPPER
			CALL	MOS_IO_PRINT_STRING
			RET
STR: db 0
