
org 100h

jmp START

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

START:			
				MOV		DI, STR
				CALL	MOS_IO_READ_STRING
				MOV		SI, STR
				CALL	MOS_IO_PRINT_STRING
				RET
STR: db 0
