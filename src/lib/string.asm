; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

;-------------------------------------------------------------------------
;  MOS_STRING_ISPREFIX() determines if str1 is a prefix of str2
;  IN: SI = str1, DI = str2
;  OUT: Carry Flag set if true
;-------------------------------------------------------------------------
MOS_STRING_ISPREFIX:
				PUSHA					; preserve registers
.MORE:			MOV 	al, [si]		; grab char from str1
				MOV 	bl, [di]		; grab char from str2
				CMP 	al, bl			; compare the two
				JNE 	.NOT			; does it match?
				INC 	si				; increment str1
				INC 	di				; increment str2
				CMP 	[si], BYTE 0	; are we at the end of str1?
				JNE 	.MORE			; loop
				JMP 	.IS				; it is a prefix
.NOT:			CLC						; clear carry flag (false)
				POPA					; restore registers
				RET						; return
.IS:			STC						; set carry flag (true)
				POPA					; restore registers
				RET						; return
;-------------------------------------------------------------------------
;  MOS_STRING_LEN() returns the length of a string
;  IN: SI = string
;  OUT: DX = length
;-------------------------------------------------------------------------
MOS_STRING_LEN:		
				MOV		DX, 0			; start off count at 0
.COUNT:			CMP		[SI], BYTE 0	; at the end of the string?
				JE		.DONE			; if so, were done here
				INC		DX				; otherwise: increment our count
				INC		SI				; move to next character
				JMP		.COUNT			; loop
.DONE:			RET						; return
