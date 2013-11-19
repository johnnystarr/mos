
org 100h

jmp start

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

start:
	call MOS_IO_READ_STRING
	call MOS_IO_PRINT_CHAR
ret

str: db "It's working!", 0
