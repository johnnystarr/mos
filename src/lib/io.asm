; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; io.asm:
; This file stores all of the I/O (Input Output) library routines


; mos_io_print_string() - Prints a string to output
; IN: SI = String to output
; OUT: none
; TODO: add features for pages and colors
mos_io_print_string:
	pusha            ; preserve registers
.do:
	lodsb            ; loads next byte into AL from SI, auto increments SI
	cmp al, 0        ; are we at the end of our string?
	je .done         ; if so, leave
	mov ah, 0Eh      ; setup AH with BIOS Int 0Eh (print char to screen)
	int 10h          ; call BIOS Int
	jmp .do          ; loop
.done:
	popa             ; restore registers, we aren't outputting a value
	ret              ; return
