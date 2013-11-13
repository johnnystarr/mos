; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

org 100h

jmp start

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
	
	
boom:
	mov ah, 09h
	mov dx, msg
	int 21h
ret

start:
	mov si, str1
	mov di, str2
	call mos_string_isprefix
	jc boom
ret


str1: db "he", 0
str2: db "hey you guys", 0
msg:  db "It's a prefix!", '$'
