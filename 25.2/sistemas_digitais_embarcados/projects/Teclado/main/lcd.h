#ifndef __MEU_LCD__
#define __MEU_LCD__

#define LOW 0
#define HIGH 1

// Limpar e retornar
#define LCD_CLEAR_DISPLAY      0x01  // Limpa todo o display
#define LCD_RETURN_HOME        0x02  // Retorna cursor à posição inicial

// Modo de entrada (movimento do cursor e deslocamento da tela)
#define LCD_ENTRY_MODE_DEC     0x04  // Cursor decrementa (esquerda)
#define LCD_ENTRY_MODE_INC     0x06  // Cursor incrementa (direita)
#define LCD_ENTRY_SHIFT_ON     0x05  // Desloca display ao escrever
#define LCD_ENTRY_SHIFT_OFF    0x04  // Não desloca display ao escrever

// Controle do display
#define LCD_DISPLAY_OFF        0x08  // Display desligado
#define LCD_DISPLAY_ON         0x0C  // Display ligado, cursor e blink off
#define LCD_DISPLAY_CURSOR     0x0E  // Display ligado + cursor ligado
#define LCD_DISPLAY_BLINK      0x0F  // Display ligado + cursor piscando

// Movimentação de cursor/display
#define LCD_SHIFT_CURSOR_LEFT  0x10
#define LCD_SHIFT_CURSOR_RIGHT 0x14
#define LCD_SHIFT_DISPLAY_LEFT 0x18
#define LCD_SHIFT_DISPLAY_RIGHT 0x1C

// Função (modo de operação)
#define LCD_FUNCTION_4BIT_1LINE_5x8  0x20
#define LCD_FUNCTION_4BIT_2LINE_5x8  0x28
#define LCD_FUNCTION_8BIT_1LINE_5x8  0x30
#define LCD_FUNCTION_8BIT_2LINE_5x8  0x38

void comando (int cmd);
void LCD_init(int rs, int E, int D7, int D6, int D5, int D4);
void LCD_string(char *st);
void LCD_caractere (char x);
void gotoXY(int col, int lin);

#endif