#include <stdio.h>

// lib para usar funções do SO, como pausas e delays
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
// lib para mexer nos pinos
#include "driver/gpio.h"

#define LOW 0
#define HIGH 1
#define BLINK_GPIO 15

void app_main(void)
{
    // reseto o pino escolhido para garantir que ele está em um estado conhecido
    gpio_reset_pin(BLINK_GPIO);

    // configura o pino como saída
    gpio_set_direction(BLINK_GPIO, GPIO_MODE_OUTPUT);

    printf("Configuração concluida. Iniciando o pisca led!\n");

    while(1) {
        // liga led
        gpio_set_level(BLINK_GPIO, HIGH);
        // delay de 500 ms
        vTaskDelay(500 / portTICK_PERIOD_MS);

        // desliga led
        gpio_set_level(BLINK_GPIO, LOW);
        // delay de 500 ms
        vTaskDelay(500 / portTICK_PERIOD_MS);
    }
}
