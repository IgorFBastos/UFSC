#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include <inttypes.h>

#include "lcd.h"

int rs = 23, E = 22, D7 = 19, D6 = 18, D5 = 5, D4 = 17;
void app_main(void)
{
    LCD_init(rs, E, D7, D6, D5, D4);
    LCD_string("Igor Bastos");
    while (1)
    {

    }
}