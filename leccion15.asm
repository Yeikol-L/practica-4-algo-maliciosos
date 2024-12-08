
%include        'functions.asm'
 
SECTION .data
msg1        db      ' sobra '      ; mensaje del remanente
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, 15     
    mov     ebx, 5      
    div     ebx         ; se divide eax por ebx
    call    iprint      ; se muestra el resultado 
    mov     eax, msg1   ; 
    call    sprint      ; se muestra el mensaje ' sobra '
    mov     eax, edx    ; 
    call    iprintLF    ; se muestra el remanente 
 
    call    quit