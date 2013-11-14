; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; mos_io_print_string() - Prints a string to output
; IN: SI = String to output
; OUT: none
; TODO: add features for pages and colors
mos_io_print_string:
	pusha
.do:
	lodsb
	cmp al, 0
	je .done
	mov ah, 0Eh
	int 10h
	jmp .do
.done:
	popa
	ret