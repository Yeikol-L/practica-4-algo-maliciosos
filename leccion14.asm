%include        'functions.asm'
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, 10     
    mov     ebx, 91      
    mul     ebx         ; se multiply eax por ebx
    call    iprintLF    ; se muestra el resultado
    call    quit