#ifndef LCD_H
#define LCD_H

// Initialize the LCD with the given pin configuration
void LCD_init(int rs, int e, int d4, int d5, int d6, int d7);
// Send a string to be displayed on the LCD
void LCD_string(char* str);
// senda a caracter to be displayed on the LCD
void LCD_caracter(char x);



#endif // LCD_H