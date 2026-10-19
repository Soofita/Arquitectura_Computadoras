#include <avr/io.h>
.equ LED0, 0 ; PB0 (Pin 14 físico)
.equ LED1, 1 ; PB1 (Pin 15 físico)
.equ LED2, 2 ; PB2 (Pin 16 físico)
.section .text
.global main
main:
; Configurar PB0, PB1 y PB2 como SALIDAS en DDRB
sbi _SFR_IO_ADDR(DDRB), LED0
sbi _SFR_IO_ADDR(DDRB), LED1
sbi _SFR_IO_ADDR(DDRB), LED2
MAIN_LOOP:
; --- 1. Encender LED 0 (PB0) ---
sbi _SFR_IO_ADDR(PORTB), LED0
cbi _SFR_IO_ADDR(PORTB), LED1
cbi _SFR_IO_ADDR(PORTB), LED2
rcall DELAY
; --- 2. Encender LED 1 (PB1) ---
cbi _SFR_IO_ADDR(PORTB), LED0
sbi _SFR_IO_ADDR(PORTB), LED1
cbi _SFR_IO_ADDR(PORTB), LED2
rcall DELAY
; --- 3. Encender LED 2 (PB2) ---
cbi _SFR_IO_ADDR(PORTB), LED0
cbi _SFR_IO_ADDR(PORTB), LED1
sbi _SFR_IO_ADDR(PORTB), LED2
rcall DELAY
; --- 4. Regresar por LED 1 (PB1) ---
cbi _SFR_IO_ADDR(PORTB), LED0
sbi _SFR_IO_ADDR(PORTB), LED1
cbi _SFR_IO_ADDR(PORTB), LED2
rcall DELAY
rjmp MAIN_LOOP
;
============================================
================
; Subrutina de retardo
;
============================================
================
DELAY:
ldi R18, 0x20 ; Ajusta este valor si quieres el péndulo
más rápido o lento
DELAY1:
ldi R19, 0xFF
DELAY2:
ldi R20, 0xFF
DELAY3:
subi R20, 1
brne DELAY3
subi R19, 1
brne DELAY2
subi R18, 1
brne DELAY1
ret
