#include <stdio.h>
#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

volatile int x = 0;

static void IRAM_ATTR tratador(void *arg)
{
    x++;
}

void app_main(void)
{

    gpio_config_t gpioConfig;

    gpioConfig.pin_bit_mask = (1ULL << 23);
    gpioConfig.mode = GPIO_MODE_INPUT;
    gpioConfig.pull_up_en = GPIO_PULLUP_ENABLE;
    gpioConfig.pull_down_en = GPIO_PULLDOWN_DISABLE;
    gpioConfig.intr_type = GPIO_INTR_NEGEDGE;

    gpio_config(&gpioConfig);

    gpio_install_isr_service(0);
    gpio_isr_handler_add(23, tratador, NULL);

    while (1)
    {
        vTaskDelay(100 / portTICK_PERIOD_MS);
        printf("valor de x = %d\n", x);
        x = 0;
    }
}
