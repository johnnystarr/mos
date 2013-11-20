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

;-------------------------------------------------------------------------
;  MOS_IO_PRINT_CHAR() - Prints a single character to output
;  IN: AL = char to output
;  OUT: none
;-------------------------------------------------------------------------

MOS_IO_PRINT_CHAR:
			MOV		AH, 0Eh			; BIOS (output char) Int
			INT		10h				; call BIOS Int
			RET
			
;-------------------------------------------------------------------------
;  MOS_IO_PRINT_STRING() - Prints a string to output
;  IN: SI = String to output
;  OUT: none
;  TODO: add features for pages and colors
;-------------------------------------------------------------------------

MOS_IO_PRINT_STRING:
			PUSHA					; preserve registers
.DO:		LODSB            		; loads next byte to AL, (INC SI)
			CMP 	AL, 0			; at the end of our string?
			JE		.DONE         	; if so, leave
			MOV		AH, 0Eh      	; BIOS (output char) Int
			INT		10h          	; call BIOS Int
			JMP		.DO          	; loop
.DONE:		POPA             		; restore regs, no output
			RET              		; return

;-------------------------------------------------------------------------
;  MOS_IO_READ_STRING() - Reads a string from input
;  IN: DI = destination of input string
;      DH = max buffer length, 
;      DL = options flag: 0000000x = echo
;                         xxxxxxx0 = unused
;  OUT: DI = modified string from input
;-------------------------------------------------------------------------

MOS_IO_READ_STRING:
			CMP		DH, 0				; is DH unitialized?
			JE		.SETBUF				; if not, lets set the limit
			JMP		.READ				; if is, start reading
.SETBUF:	MOV		DH, 254				; set limit to 254+'\0' = 0-255
.READ:		CMP		DH, 0				; check buffer boundry
			JE		.DONE				; finish up if we hit our max
			DEC		DH					; decrement our buffer counter
			MOV		AH, 00h				; setup for read keyboard input
			INT		16h					; call BIOS keyboard service
			STOSB						; store AL in str, inc DI
			TEST	DL, 00000001b   	; check echo flag
			JNE		.ECHO				; go to echo stage
			JMP		.NOECHO				; bypass echo
.ECHO:		CALL	MOS_IO_PRINT_CHAR	; call API routine to echo
.NOECHO:	CMP		AL, 0Dh				; end of string? (enter pressed)
			JNE		.READ				; if not, read more
.DONE:		DEC		DI					; if so, set us back one
			MOV		[DI], BYTE 0		; terminate our string asciiz
			RET							; return

;-------------------------------------------------------------------------
;  End Of File
;-------------------------------------------------------------------------