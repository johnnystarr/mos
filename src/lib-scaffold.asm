
BITS 16

org 100h



jmp START

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

START:		

			MOV		AX, 04					; AH: 00, AL: 03 80x25 graphics
			INT		10h						; call BIOS video mode

			MOV		AH, 0Bh
			MOV		BX, 1
			INT		10h
			
			MOV		BL, 0x0F
			
			MOV		SI, STR
			CALL	MOS_IO_PRINT_STRING_C
			
			MOV		CX, 2
			CALL	MOS_IO_NEW_LINE
			
			MOV		BL, 0x2D
			
			MOV		SI, STR2
			CALL	MOS_IO_PRINT_STRING_C
			
			RET
			

STR: 		DB "Hey you guys!", 0
STR2:		DB "This is awesome!", 0