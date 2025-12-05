#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include <inttypes.h>

#include "lcd.h"
#include "teclado.h"


void LCD (void * args)
{
    init_teclado();
    char tecla;
    while (1)
    {
        // Ler a tecla pressionada
        tecla = leiaTecla();
    
        if (tecla != '\0')
        {
            printf("Tecla pressionada: %c\n", tecla);
            vTaskDelay(pdMS_TO_TICKS(500)); // Debounce
        }
    }
}

void app_main(void)
{
    xTaskCreate(LCD, "tarefa_LCD", 2048, NULL, 5, NULL);
}