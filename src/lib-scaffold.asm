
org 100h

jmp start

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

start:
	mov si, str
	call MOS_IO_PRINT_STRING
ret

str: db "It's working!", 0
