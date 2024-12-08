%include        'functions.asm'
 
SECTION .text
global  _start
 
_start:
 
    mov     ecx, 0
 
nextNumber:
    inc     ecx
    mov     eax, ecx
    call    iprintLF        ; Llamando la nueva funcion iprintLF
    cmp     ecx, 10
    jne     nextNumber
 
    call    quit