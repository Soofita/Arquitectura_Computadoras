#include <avr/io.h>
.section .text
.global main
main:
; Configurar PB0, PB1 y PB2 como salidas (DDRB = 0x07)
ldi r16, 0x07
out _SFR_IO_ADDR(DDRB), r16
; Configurar PC0 y PC1 como entradas con Pull-Up interno
clr r16
out _SFR_IO_ADDR(DDRC), r16
ldi r16, 0x03
out _SFR_IO_ADDR(PORTC), r16
MAIN_LOOP:
; Paso 1: Encender D1 (PB0)
ldi r16, 0b00000001
out _SFR_IO_ADDR(PORTB), r16
rcall READ_DELAY
; Paso 2: Encender D2 (PB1)
ldi r16, 0b00000010
out _SFR_IO_ADDR(PORTB), r16
rcall READ_DELAY
; Paso 3: Encender D3 (PB2)
ldi r16, 0b00000100
out _SFR_IO_ADDR(PORTB), r16
rcall READ_DELAY
; Paso 4: Regresar a D2 (PB1)
ldi r16, 0b00000010
out _SFR_IO_ADDR(PORTB), r16
rcall READ_DELAY
rjmp MAIN_LOOP
;
============================================
================
; Convierte la lectura de PC0-PC1 a un valor de retardo
;
============================================
================
READ_DELAY:
in r18, _SFR_IO_ADDR(PINC)
com r18
andi r18, 0x03
cpi r18, 0
breq OPTION_00
cpi r18, 1
breq OPTION_01
cpi r18, 2
breq OPTION_10
OPTION_11:
ldi r18, 0x0F
rjmp DO_DELAY
OPTION_10:
ldi r18, 0xC0
rjmp DO_DELAY
OPTION_01:
ldi r18, 0xF0
rjmp DO_DELAY
OPTION_00:
ldi r18, 0xFF
DO_DELAY:
DELAY_LOOP1:
ldi r24, 0x9F
ldi r25, 0x0F
DELAY_LOOP2:
sbiw r24, 1
brne DELAY_LOOP2
subi r18, 1
brne DELAY_LOOP1
ret
