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

start:         
    mov si, str
    call mos_string_len
        
    mov ah, 02h    
    int 21h
ret

str: db "abcdfghijk", 0
