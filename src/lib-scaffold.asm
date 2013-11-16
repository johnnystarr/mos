; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; lib-scaffold.asm:
; this file is used to facilitate a scaffold for development and testing
; of lib files.  This will be key in testing individual assembly files.
; the main output of this file will be .COM and be used in a DOS env.

org 100h     ; all COM files start in this location in DOS
jmp start

%INCLUDE "lib/string.asm"
%INCLUDE "lib/io.asm"

start:
	; test mos_string_isprefix

	mov si, pre
	mov di, str
	call mos_string_isprefix
	jc .is_prefix
	jmp .done

.is_prefix:
	mov si, str
	call mos_io_print_string
.done:
	ret

pre: db "He", 0
str: db "Hey, It's really working!!!", 0

