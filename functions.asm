;------------------------------------------
; void iprint(Integer number)
; Función para imprimir un número entero (itoa)
iprint:
    push    eax             ; preservar eax en la pila para restaurarlo después de ejecutar la función
    push    ecx             ; preservar ecx en la pila para restaurarlo después de ejecutar la función
    push    edx             ; preservar edx en la pila para restaurarlo después de ejecutar la función
    push    esi             ; preservar esi en la pila para restaurarlo después de ejecutar la función
    mov     ecx, 0          ; contador de cuántos bytes necesitamos imprimir al final

divideLoop:
    inc     ecx             ; contar cada byte a imprimir - número de caracteres
    mov     edx, 0          ; vaciar edx
    mov     esi, 10         ; mover 10 a esi
    idiv    esi             ; dividir eax por esi
    add     edx, 48         ; convertir edx a su representación ASCII - edx contiene el resto después de una instrucción de división
    push    edx             ; apilar edx (representación en cadena de un entero) en la pila
    cmp     eax, 0          ; ¿se puede seguir dividiendo el número entero?
    jnz     divideLoop      ; saltar si no es cero a la etiqueta divideLoop

printLoop:
    dec     ecx             ; descontar cada byte que colocamos en la pila
    mov     eax, esp        ; mover el puntero de pila a eax para imprimir
    call    sprint          ; llamar a nuestra función para imprimir cadenas
    pop     eax             ; eliminar el último carácter de la pila para avanzar esp
    cmp     ecx, 0          ; ¿hemos impreso todos los bytes apilados?
    jnz     printLoop       ; saltar si no es cero a la etiqueta printLoop

    pop     esi             ; restaurar esi desde el valor apilado al inicio
    pop     edx             ; restaurar edx desde el valor apilado al inicio
    pop     ecx             ; restaurar ecx desde el valor apilado al inicio
    pop     eax             ; restaurar eax desde el valor apilado al inicio
    ret

;------------------------------------------
; void iprintLF(Integer number)
; Función para imprimir un número entero con salto de línea (itoa)
iprintLF:
    call    iprint          ; llamar a nuestra función para imprimir enteros

    push    eax             ; apilar eax para preservarlo mientras usamos el registro eax en esta función
    mov     eax, 0Ah        ; mover 0Ah a eax - 0Ah es el carácter ASCII para un salto de línea
    push    eax             ; apilar el salto de línea para obtener la dirección
    mov     eax, esp        ; mover la dirección del puntero de pila actual a eax para sprint
    call    sprint          ; llamar a nuestra función sprint
    pop     eax             ; eliminar el carácter de salto de línea de la pila
    pop     eax             ; restaurar el valor original de eax antes de llamar a la función
    ret

;------------------------------------------
; int slen(String message)
; Función para calcular la longitud de una cadena
slen:
    push    ebx
    mov     ebx, eax

nextchar:
    cmp     byte [eax], 0   ; comparar si el carácter actual es el fin de cadena (nulo)
    jz      finished        ; saltar a finished si es nulo
    inc     eax             ; avanzar al siguiente carácter
    jmp     nextchar        ; repetir el ciclo

finished:
    sub     eax, ebx        ; calcular la longitud restando la posición inicial
    pop     ebx             ; restaurar ebx
    ret

;------------------------------------------
; void sprint(String message)
; Función para imprimir cadenas
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen            ; calcular la longitud de la cadena

    mov     edx, eax        ; mover la longitud calculada a edx
    pop     eax

    mov     ecx, eax        ; mover el puntero de la cadena a ecx
    mov     ebx, 1          ; descriptor de archivo para salida estándar
    mov     eax, 4          ; syscall para escribir
    int     80h             ; llamar a la interrupción del sistema

    pop     ebx
    pop     ecx
    pop     edx
    ret

;------------------------------------------
; void sprintLF(String message)
; Función para imprimir cadenas con salto de línea
sprintLF:
    call    sprint          ; llamar a la función para imprimir cadenas

    push    eax
    mov     eax, 0AH        ; mover el carácter de salto de línea a eax
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret
    
;------------------------------------------
; int atoi(Integer number)
; Función para convertir de ASCII a entero (atoi)
atoi:
    push    ebx             ; preservar ebx en la pila para restaurarlo después de ejecutar la función
    push    ecx             ; preservar ecx en la pila para restaurarlo después de ejecutar la función
    push    edx             ; preservar edx en la pila para restaurarlo después de ejecutar la función
    push    esi             ; preservar esi en la pila para restaurarlo después de ejecutar la función
    mov     esi, eax        ; mover el puntero en eax a esi (nuestro número a convertir)
    mov     eax, 0          ; inicializar eax con el valor decimal 0
    mov     ecx, 0          ; inicializar ecx con el valor decimal 0

.multiplyLoop:
    xor     ebx, ebx        ; reiniciar los bytes superior e inferior de ebx a 0
    mov     bl, [esi+ecx]   ; mover un byte al registro inferior de ebx
    cmp     bl, 48          ; comparar el valor del registro inferior de ebx con el valor ASCII 48 (carácter '0')
    jl      .finished       ; saltar a la etiqueta finished si es menor
    cmp     bl, 57          ; comparar el valor del registro inferior de ebx con el valor ASCII 57 (carácter '9')
    jg      .finished       ; saltar a la etiqueta finished si es mayor

    sub     bl, 48          ; convertir el valor del registro inferior de ebx a su representación decimal
    add     eax, ebx        ; sumar ebx a nuestro valor entero en eax
    mov     ebx, 10         ; mover el valor decimal 10 a ebx
    mul     ebx             ; multiplicar eax por ebx para obtener el valor posicional
    inc     ecx             ; incrementar ecx (nuestro registro contador)
    jmp     .multiplyLoop   ; continuar el bucle de multiplicación

.finished:
    cmp     ecx, 0          ; comparar el valor del registro ecx con el decimal 0 (nuestro registro contador)
    je      .restore        ; saltar si es igual a 0 (no se pasaron argumentos enteros a atoi)
    mov     ebx, 10         ; mover el valor decimal 10 a ebx
    div     ebx             ; dividir eax por el valor en ebx (en este caso, 10)

.restore:
    pop     esi             ; restaurar esi desde el valor apilado al inicio
    pop     edx             ; restaurar edx desde el valor apilado al inicio
    pop     ecx             ; restaurar ecx desde el valor apilado al inicio
    pop     ebx             ; restaurar ebx desde el valor apilado al inicio
    ret

;------------------------------------------
; void exit()
; Función para salir del programa y liberar recursos
quit:
    mov     ebx, 0          ; código de salida
    mov     eax, 1          ; syscall para salir
    int     80h             ; llamar a la interrupción del sistema
    ret
