
org 100h

jmp start

%INCLUDE "lib/io.asm"
%INCLUDE "lib/string.asm"

start:
	mov si, str
	call mos_io_print_string
ret

str: db "It's working!", 0
