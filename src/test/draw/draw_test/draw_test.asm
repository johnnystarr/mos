
BITS 16

org 100h

jmp START

%INCLUDE "../../../lib/io.asm"
%INCLUDE "../../../lib/string.asm"
;-------------------------------------------------------------------------

START:
                MOV		AX, 0x0D		; AH: 00, AL: 0D = EGA 16 COLOR

                
                
                RET