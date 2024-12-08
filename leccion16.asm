%include        'functions.asm'
 
SECTION .text
global  _start
 
_start:
 
    pop     ecx             
    pop     edx             
    sub     ecx, 1          
    mov     edx, 0          
 
nextArg:
    cmp     ecx, 0h         ; comprobar si nos quedan argumentos
    jz      noMoreArgs      ; si el indicador de cero está establecido, saltar a la etiqueta noMoreArgs (saltando el final del bucle)
    pop     eax             ; sacar el siguiente argumento de la pila
    call    atoi            ; convertir nuestra cadena ASCII a un número entero decimal
    add     edx, eax        ; realizar la lógica de suma
    dec     ecx             ; disminuir ecx (número de argumentos restantes) en 1
    jmp     nextArg         ; saltar a la etiqueta nextArg

noMoreArgs:
    mov     eax, edx        ; mover el resultado de la operación a eax para imprimir
    call    iprintLF        ; llamar a nuestra función para imprimir enteros con salto de línea
    call    quit            ; llamar a nuestra función para salir
