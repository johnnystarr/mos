; _|      _|    _|_|      _|_|_|      
; _|_|  _|_|  _|    _|  _|            
; _|  _|  _|  _|    _|    _|_|        
; _|      _|  _|    _|        _|      
; _|      _|    _|_|    _|_|_|  
;
; The [M]inimalist [O]perating [S]ystem
; Created by Johnny Starr (c) 2013
; www.thestarrlab.com

; lib-scaffold.asm:
; this file is used to facilitate a scaffold for development and testing
; of lib files.  This will be key in testing individual assembly files.
; the main output of this file will be .COM and be used in a DOS env.

org 100h     ; all COM files start in this location in DOS

%INCLUDE "lib/string.asm"
%INCLUDE "lib/io.asm"





ret