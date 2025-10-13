#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"

// Pinos dos segmentos (ajusta conforme tua ligação)
#define SEG_A 2
#define SEG_B 4
#define SEG_C 5
#define SEG_D 18
#define SEG_E 19
#define SEG_F 21
#define SEG_G 22

// Pinos de controle dos displays
#define DISP1 23
#define DISP2 15

// Mapas dos dígitos (a,b,c,d,e,f,g)
int digitos[10][7] = {
    {1,1,1,1,1,1,0}, // 0
    {0,1,1,0,0,0,0}, // 1
    {1,1,0,1,1,0,1}, // 2
    {1,1,1,1,0,0,1}, // 3
    {0,1,1,0,0,1,1}, // 4
    {1,0,1,1,0,1,1}, // 5
    {1,0,1,1,1,1,1}, // 6
    {1,1,1,0,0,0,0}, // 7
    {1,1,1,1,1,1,1}, // 8
    {1,1,1,1,0,1,1}  // 9
};

void escreve_digito(int n) {
    gpio_set_level(SEG_A, digitos[n][0]);
    gpio_set_level(SEG_B, digitos[n][1]);
    gpio_set_level(SEG_C, digitos[n][2]);
    gpio_set_level(SEG_D, digitos[n][3]);
    gpio_set_level(SEG_E, digitos[n][4]);
    gpio_set_level(SEG_F, digitos[n][5]);
    gpio_set_level(SEG_G, digitos[n][6]);
}

void task_multiplex(void *pvParameter) {
    int unidade = 2;
    int dezena = 1;

    while (1) {
        // Mostra unidade
        escreve_digito(unidade);
        gpio_set_level(DISP1, 1);
        gpio_set_level(DISP2, 0);
        vTaskDelay(5 / portTICK_PERIOD_MS);

        // Mostra dezena
        escreve_digito(dezena);
        gpio_set_level(DISP1, 0);
        gpio_set_level(DISP2, 1);
        vTaskDelay(5 / portTICK_PERIOD_MS);
    }
}

void app_main(void) {
    int pinos[] = {SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G, DISP1, DISP2};

    for (int i = 0; i < 9; i++) {
        gpio_set_direction(pinos[i], GPIO_MODE_OUTPUT);
        gpio_set_level(pinos[i], 0);
    }

    xTaskCreate(task_multiplex, "task_multiplex", 2048, NULL, 1, NULL);
}
