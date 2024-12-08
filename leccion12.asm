%include        'functions.asm'
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, 90     
    mov     ebx, 9      
    add     eax, ebx    
    call    iprintLF    ; Ejecutar nuestra funcion con salto de linea
 
    call    quit