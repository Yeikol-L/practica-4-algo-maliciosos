%include        'functions.asm'

SECTION .data
msg1        db      'Saltando a la etiqueta finished.', 0h        ; una cadena de mensaje
msg2        db      'Dentro de la subrutina número: ', 0h         ; una cadena de mensaje
msg3        db      'Dentro de la subrutina "finished".', 0h      ; una cadena de mensaje

SECTION .text
global  _start

_start:

subrountineOne:
    mov     eax, msg1       ; mover la dirección de msg1 a eax
    call    sprintLF        ; llamar a nuestra función para imprimir cadenas con salto de línea
    jmp     .finished       ; saltar a la etiqueta local .finished dentro de subrountineOne

.finished:
    mov     eax, msg2       ; mover la dirección de msg2 a eax
    call    sprint          ; llamar a nuestra función para imprimir cadenas
    mov     eax, 1          ; mover el valor uno a eax (para la subrutina número uno)
    call    iprintLF        ; llamar a nuestra función para imprimir enteros con salto de línea

subrountineTwo:
    mov     eax, msg1       ; mover la dirección de msg1 a eax
    call    sprintLF        ; llamar a nuestra función para imprimir cadenas con salto de línea
    jmp     .finished       ; saltar a la etiqueta local .finished dentro de subrountineTwo

.finished:
    mov     eax, msg2       ; mover la dirección de msg2 a eax
    call    sprint          ; llamar a nuestra función para imprimir cadenas
    mov     eax, 2          ; mover el valor dos a eax (para la subrutina número dos)
    call    iprintLF        ; llamar a nuestra función para imprimir enteros con salto de línea

    mov     eax, msg1       ; mover la dirección de msg1 a eax
    call    sprintLF        ; llamar a nuestra función para imprimir cadenas con salto de línea
    jmp     finish          ; saltar a la etiqueta global finish

finish:
    mov     eax, msg3       ; mover la dirección de msg3 a eax
    call    sprintLF        ; llamar a nuestra función para imprimir cadenas con salto de línea
    call    quit            ; llamar a nuestra función para salir