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
.DO:			LODSB            		; loads next byte to AL, (INC SI)
				CMP 	AL, 0			; at the end of our string?
				JE		.DONE         	; if so, leave
				MOV		AH, 0Eh      	; BIOS (output char) Int
				INT		10h          	; call BIOS Int
				JMP		.DO          	; loop
.DONE:			POPA             		; restore regs, no output
				RET              		; return

;-------------------------------------------------------------------------
;  MOS_IO_READ_STRING() - Reads a string from input
;  IN: none
;  OUT: AL = char input
;  TODO: complete by reading whole string  and returning pointer to str
;-------------------------------------------------------------------------

MOS_IO_READ_STRING:
				MOV		AH, 00h			; setup for read keyboard input
				INT		16h				; call BIOS keyboard service		
				RET

;-------------------------------------------------------------------------
;  End Of File
;-------------------------------------------------------------------------