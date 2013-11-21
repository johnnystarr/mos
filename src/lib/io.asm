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
;      DL = options flag: 0000000x = no carriage return
;  OUT: none
;-------------------------------------------------------------------------

MOS_IO_PRINT_STRING:
			PUSHA					; preserve registers
.DO:		LODSB            		; loads next byte to AL, (INC SI)
			CMP 	AL, 0			; at the end of our string?
			JE		.DONE         	; if so, leave
			MOV		AH, 0Eh      	; BIOS (output char) Int
			INT		10h          	; call BIOS Int
			JMP		.DO          	; loop
.DONE:		TEST	DL, 00000001b	; check no carriage return flag
			JNE		.NC				; if checked, goto NC (no carriage)
			CALL	MOS_IO_NEW_LINE ; send new line to output
.NC:		POPA             		; restore regs, no output
			RET              		; return

;-------------------------------------------------------------------------
;  MOS_IO_PRINT_STRING_C() - Prints a string to output (in color!)
;  IN: SI = String to output, BL = color: left nib = bg, right nib = fg
;  OUT: none
;-------------------------------------------------------------------------

MOS_IO_PRINT_STRING_C:
			PUSHA					; preserve registers
			MOV     AH, 03h			; get current location of cursor
			INT     10h				; call BIOS 
.DO:		LODSB					; load the next char from our string
			CMP     AL, 0			; at the end of our string?
			JE      .DONE			; if so, leave        
			MOV     AH, 02h			; set cursor pos: whatever is set
			INT     10h				; call BIOS
			INC     DL				; increase cursor horiz pos
			MOV     AH, 09h			; output char with attributes
			MOV     BH, 0			; set page to write to
			MOV     CX, 1			; number of times to print character
			INT     10h				; call BIOS
			JMP     .DO				; loop
.DONE:      CALL	MOS_IO_NEW_LINE	; send new line to output
			POPA					; restore registers
            RET						; return

;-------------------------------------------------------------------------
;  MOS_IO_NEW_LINE() - outputs a carriage return and new line
;  IN / OUT: none
;-------------------------------------------------------------------------
MOS_IO_NEW_LINE:
			PUSH	AX				; preserve AX
			MOV		AH, 0Eh			; setup AH for BIOS output char
			MOV		AL, 0Dh			; carriage return
			INT		10h				; output carriage return
			MOV		AL, 0Ah			; new line
			INT		10h				; output new line	
			POP		AX				; restore AX
			RET			
			
;-------------------------------------------------------------------------
;  MOS_IO_READ_STRING() - Reads a string from input
;  IN: DI = destination of input string
;      DH = max buffer length (default value 254 if DH = 0)
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
			DEC		DI					; if so, set us back one
.DONE:		MOV		[DI], BYTE 0		; terminate our string asciiz
			RET							; return

;-------------------------------------------------------------------------
;  End Of File
;-------------------------------------------------------------------------