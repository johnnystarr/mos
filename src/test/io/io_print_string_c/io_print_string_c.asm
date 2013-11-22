
BITS 16

org 100h

jmp START

%INCLUDE "../../../lib/io.asm"
%INCLUDE "../../../lib/string.asm"
;-------------------------------------------------------------------------

START:
			MOV		AX, 0x0D		; AH: 00, AL: 0D = EGA 16 COLOR
			INT		10h				; call BIOS video mode
			MOV		AH, 0Bh
			MOV		BX, 00
			INT		10h
			MOV		CX, 0x16
.DO:		MOV		BX, CX
			MOV		SI, STR
			CALL	MOS_IO_PRINT_STRING_C
			LOOP	.DO
			RET
			
STR: 		DB "Give life back to music!", 0
