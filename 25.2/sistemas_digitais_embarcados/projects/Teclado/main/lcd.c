#include "lcd.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include <inttypes.h>

int pin_d7, pin_d6, pin_d5, pin_d4, pin_rs, pin_e;


void escreve_4bits (int rs, uint8_t v)
{
    gpio_set_level(pin_rs, rs);

    gpio_set_level(pin_d7, (v >> 3) & 1);
    gpio_set_level(pin_d6, (v >> 2) & 1);
    gpio_set_level(pin_d5, (v >> 1) & 1);
    gpio_set_level(pin_d4, v & 1);
    gpio_set_level(pin_e, HIGH);

    vTaskDelay(2 / portTICK_PERIOD_MS);

    gpio_set_level(pin_e, LOW);
    vTaskDelay(15 / portTICK_PERIOD_MS);
}
void comando (int cmd)
{
    escreve_4bits(0, cmd>>4);
    escreve_4bits(0, cmd);
}

void gotoXY(int col, int lin)
{
    uint8_t comando, end;

    if (lin == 0) end = col;
    else end = 0x40+col;

    comando = 0x80 | end;

    escreve_4bits(0, comando >> 4);
    escreve_4bits(0, comando);
}
void LCD_init(int rs, int E, int D7, int D6, int D5, int D4)
{
    gpio_config_t io_conf;

    pin_d7 = D7; pin_d6 = D6; pin_d5 = D5; pin_d4 = D4;
    pin_rs = rs; pin_e = E;

    uint32_t saida = (1<<rs) | (1<<E) | (1<<D7) | (1<<D6) | (1<<D5) | (1 << D4);
    io_conf.intr_type = GPIO_INTR_DISABLE;//sem interrupcoes
    io_conf.mode = GPIO_MODE_OUTPUT;//pinos de saida
    io_conf.pin_bit_mask = saida;
    io_conf.pull_down_en = GPIO_PULLDOWN_DISABLE;// sem pulldown
    io_conf.pull_up_en = GPIO_PULLUP_DISABLE;//sem pullUP
    gpio_config(&io_conf);

    gpio_set_level(E, LOW);

    vTaskDelay(100 / portTICK_PERIOD_MS);

    // CONFIGURA
    escreve_4bits(0, 3);
    escreve_4bits(0, 3);
    escreve_4bits(0, 3);

    // USA MODO 4 bits
    escreve_4bits(0, 2);

    // CONFIGURA

    // 4 bits, 2 linhas, fonte 5x8
    comando(LCD_FUNCTION_4BIT_2LINE_5x8);

    // Display on , cursor off
    comando(LCD_DISPLAY_ON);

    // Cursor a direita
    comando(LCD_ENTRY_MODE_INC);


    // limpa display
    comando(LCD_CLEAR_DISPLAY);

    // Move cursor para primeira linha, primeira coluna
    comando(LCD_RETURN_HOME);

    vTaskDelay(10 / portTICK_PERIOD_MS);

}
void LCD_caractere(char x)
{
     escreve_4bits(1, x>>4);
     escreve_4bits(1, x);
}

void LCD_string(char *st)
{
    int x=0;
    while (st[x] != 0)
    {
        LCD_caractere(st[x]);
        x++;
    }
}