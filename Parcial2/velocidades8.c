#include <avr/io.h>
#include <avr/pgmspace.h>
#include <util/delay.h>
// Almacenamiento de las 8 velocidades (milisegundos) en
memoria FLASH (PROGMEM)
const uint16_t retardos_flash[8] PROGMEM = {
1000, // 000: Muy lento
700, // 001
500, // 010
350, // 011
200, // 100
120, // 101
70, // 110
};
// Función auxiliar para delay dinámico obteniendo valor
desde Flash
void retardo_variable(uint8_t indice) {
uint16_t ms = pgm_read_word(&retardos_flash[indice &
0x07]);
while (ms--) {
_delay_ms(1);
}
}
int main(void) {
// Configurar Puerto B (PB0..PB3) como Salidas para los 4
LEDs
DDRB |= 0x0F; // PB0, PB1, PB2, PB3
PORTB &= ~0x0F; // Inicializar LEDs apagados
// Configurar PD2, PD3, PD4 como Entradas para el DIP
Switch
DDRD &= ~((1 << PD2) | (1 << PD3) | (1 << PD4));
// Activar resistencias internas Pull-Up en PD2, PD3, PD4
PORTD |= (1 << PD2) | (1 << PD3) | (1 << PD4);
// Secuencia del Péndulo con 4 LEDs: PB0 -> PB1 -> PB2 -
> PB3 -> PB2 -> PB1
const uint8_t secuencia[] = {
0b00000001, // LED 1 (PB0)
0b00000010, // LED 2 (PB1)
0b00000100, // LED 3 (PB2)
0b00001000, // LED 4 (PB3)
0b00000100, // LED 3 (PB2)
0b00000010 // LED 2 (PB1)
};
uint8_t paso = 0;
while (1) {
// Mostrar estado actual en el puerto de los LEDs
PORTB = (PORTB & ~0x0F) | secuencia[paso];
// Leer DIP switch (Lógica invertida debido a Pull-Up)
uint8_t lectura_sw = (PIND >> PD2) & 0x07;
uint8_t seleccion = (~lectura_sw) & 0x07;
// Esperar según el retardo leído de Flash
retardo_variable(seleccion);
// Avanzar en la secuencia del péndulo (6 pasos en total para
ir y volver)
paso++;
if (paso >= 6) {
paso = 0;
}
}
