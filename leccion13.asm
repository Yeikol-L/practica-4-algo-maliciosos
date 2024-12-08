%include        'functions.asm'
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, 90     
    mov     ebx, 9      
    sub     eax, ebx    ; restarle ebx a eax
    call    iprintLF    ; Mostrar el entero
 
    call    quit