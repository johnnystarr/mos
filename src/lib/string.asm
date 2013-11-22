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
;  MOS_STRING_ISPREFIX() - determines if str1 is a prefix of str2
;  IN: SI = str1, DI = str2
;  OUT: Carry Flag set if true
;-------------------------------------------------------------------------

MOS_STRING_ISPREFIX:
            PUSHA                   ; preserve registers
.MORE:      MOV     AL, [SI]        ; grab char from str1
            MOV     BL, [DI]        ; grab char from str2
            CMP     AL, BL          ; compare the two
            JNE     .NOT            ; does it match?
            INC     SI              ; increment str1
            INC     DI              ; increment str2
            CMP     [SI], BYTE 0    ; are we at the end of str1?
            JNE     .MORE           ; loop
            JMP     .IS             ; it is a prefix
.NOT:       CLC                     ; clear carry flag (false)
            POPA                    ; restore registers
            RET                     ; return
.IS:        STC                     ; set carry flag (true)
            POPA                    ; restore registers
            RET                     ; return

;-------------------------------------------------------------------------
;  MOS_STRING_LEN() - returns the length of a string
;  IN: SI = string
;  OUT: DX = length
;-------------------------------------------------------------------------

MOS_STRING_LEN:
            MOV     DX, 0           ; start off count at 0
.COUNT:     CMP     [SI], BYTE 0    ; at the end of the string?
            JE      .DONE           ; if so, were done here
            INC     DX              ; otherwise: increment our count
            INC     SI              ; move to next character
            JMP     .COUNT          ; loop
.DONE:      RET                     ; return

;-------------------------------------------------------------------------
;  MOS_STRING_TOUPPER() - converts a full string to uppercase
;  IN \ OUT: SI = string to modify
;-------------------------------------------------------------------------

MOS_STRING_TOUPPER:
            PUSHA                   ; preserve registers
.DO:        CMP     BYTE [SI], 0    ; end of string?
            JE      .DONE           ; if so, return
            CMP     BYTE [SI], 'a'  ; is it within a-z range?
            JB      .NALPHA         ; if not, skip
            CMP     BYTE [SI], 'z'  ; check for a-z range again
            JA      .NALPHA         ; and skip
            SUB     BYTE [SI], 20h  ; sub 20h to ascii code, uppercase
            INC     SI              ; increment by 1
            JMP     .DO             ; read next character
.NALPHA:    INC     SI              ; skip non a-z
            JMP     .DO             ; loop
.DONE:      POPA                    ; restore registers
            RET                     ; return

;-------------------------------------------------------------------------
;  MOS_STRING_TOLOWER() - converts a full string to lowercase
;  IN \ OUT: SI = string to modify
;-------------------------------------------------------------------------

MOS_STRING_TOLOWER:
            PUSHA                   ; preserve registers
.DO:        CMP     BYTE [SI], 0    ; end of string?
            JE      .DONE           ; if so, return
            CMP     BYTE [SI], 'A'  ; is it within A-Z range?
            JB      .NALPHA         ; if not, skip
            CMP     BYTE [SI], 'Z'  ; check for A-Z range again
            JA      .NALPHA         ; and skip
            ADD     BYTE [SI], 20h  ; add 20h to ascii code, lowercase
            INC     SI              ; increment by 1
            JMP     .DO             ; read next character
.NALPHA:    INC     SI              ; skip non A-Z
            JMP     .DO             ; loop
.DONE:      POPA                    ; restore registers
            RET                     ; return

;-------------------------------------------------------------------------
;  End Of File
;-------------------------------------------------------------------------