#include "lcd.h"
// lib para usar funções do SO, como pausas e delays
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
// lib para mexer nos pinos
#include "driver/gpio.h"

#define HIGH 1
#define LOW 0

int pin_d4, pin_d5, pin_d6, pin_d7, pin_rs, pin_e;

// escreve o valor passado
void escreve_4bits(int rs, uint8_t v) {
    gpio_set_level(pin_rs, rs);
    gpio_set_level(pin_d4, (v >> 0) & 0x01);
    gpio_set_level(pin_d5, (v >> 1) & 0x01);
    gpio_set_level(pin_d6, (v >> 2) & 0x01);
    gpio_set_level(pin_d7, (v >> 3) & 0x01);
    gpio_set_level(pin_e, HIGH);
    vTaskDelay(pdMS_TO_TICKS(10));
    gpio_set_level(pin_e, LOW);
}

// Configura o lcd (codigo de configuração pego do professor)
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

    vTaskDelay(pdMS_TO_TICKS(15));
    escreve_4bits(0, 3);
    escreve_4bits(0, 3);
    escreve_4bits(0, 3);
    escreve_4bits(0, 2);

    escreve_4bits(0, 2);
    escreve_4bits(0, 8);

    escreve_4bits(0, 0);
    escreve_4bits(0, 12);

    escreve_4bits(0,0);
    escreve_4bits(0, 6);

    escreve_4bits(0, 0);
    escreve_4bits(0, 1);

    escreve_4bits(0, 8);
    escreve_4bits(0, 0);

}

// escreve o caracter no disolay
void LCD_caracter(char c) {
    escreve_4bits(1, c >> 4); // Envia os 4 bits mais significativos
    escreve_4bits(1, c & 0x0F); // Envia os 4 bits menos significativos
}

// escfeve uma string completa no display
void LCD_string(char* str) {
    // manda um caracter da string por vez
    while (*str) {
        LCD_caracter(*str++);
    }
}