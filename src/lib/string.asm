; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; mos_string_isprefix() determines if str1 is a prefix of str2
; IN: SI = str1, DI = str2
; OUT: Carry Flag set if true
mos_string_isprefix:
	pusha             ; preserve registers
.more:
	mov al, [si]      ; grab char from str1
	mov bl, [di]      ; grab char from str2
	cmp al, bl        ; compare the two
	jne .not          ; does it match?
	inc si            ; increment str1
	inc di            ; increment str2
	cmp [si], byte 0  ; are we at the end of str1?
	jne .more         ; loop
	jmp .is           ; it is a prefix
.not:
	clc               ; clear carry flag (false)
	popa              ; restore registers
	ret               ; return
.is:
	stc               ; set carry flag (true)
	popa              ; restore registers
	ret               ; return

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