; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; isprefix() determines if string '1' is a prefix of string '2'
; IN: SI = string 1, DI = string 2
; OUT: Carry Flag set if true
mos_string_isprefix:
	pusha
.more:
	mov al, [si]
	mov bl, [di]
	cmp al, bl
	jne .not
	inc si
	inc di
	cmp [si], byte 0
	jne .more
	jmp .is
.not:
	clc
	popa
	ret
.is:
	stc
	popa
	ret
ret

; mos_string_len() returns the length of a string
; IN: SI = string
; OUT: DX = length
mos_string_len:     
    mov dx, 0         ; start off count at 0
.count:            
    cmp [si], byte 0  ; are we at the end of the string?
    je .done          ; if so, were done here
    inc dx            ; otherwise: increment our count
    inc si            ; move to next character
    jmp .count        ; loop
.done:               
    ret               ; return