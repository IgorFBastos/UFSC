#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include <inttypes.h>

#include "lcd.h"
#include "teclado.h"

int rs = 23, E = 22, D7 = 19, D6 = 18, D5 = 5, D4 = 21;


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
            LCD_caracter(tecla);
            vTaskDelay(pdMS_TO_TICKS(300)); // Debounce
        }
    }
}

void app_main(void)
{
    LCD_init(rs, E, D7, D6, D5, D4);
    // LCD_string("LCD Funcionando!"); // mensagem teste 
    xTaskCreate(LCD, "tarefa_LCD", 2048, NULL, 5, NULL);
}
