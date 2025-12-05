#include <stdio.h>
#include <driver/adc.h>
#include "freertos/FreeRTOS.h"

#define ADC_CHANNEL ADC1_CHANNEL_6 // GPIO34

#define TECLA_1 4095
#define TECLA_2	3834
#define TECLA_3	3574
#define TECLA_4	3313
#define TECLA_5	3071
#define TECLA_6	2829
#define TECLA_7	2494
#define TECLA_8	2308
#define TECLA_9	2010
#define TECLA_0	1824
#define TECLA_A	1564
#define TECLA_B	1229
#define TECLA_C	1024
#define TECLA_D	819
#define TECLA_E	521
#define TECLA_F	261


void app_main(void)
{
    // Define a resolução do ADC1.
    adc1_config_width(ADC_WIDTH_BIT_12);

    // Configura o canal do ADC e o nível de atenuação.
    adc1_config_channel_atten(ADC_CHANNEL, ADC_ATTEN_DB_0);
    
    while (1)
    {

        int ValorADC = adc1_get_raw(ADC_CHANNEL);

        // if(ValorADC >= TECLA_1 - 50 && ValorADC <= TECLA_1 + 50)
        //     printf("Tecla 1 pressionada\n");
        // else if(ValorADC >= TECLA_2 - 50 && ValorADC <= TECLA_2 + 50)
        //     printf("Tecla 2 pressionada\n");
        // else if(ValorADC >= TECLA_3 - 50 && ValorADC <= TECLA_3 + 50)
        //     printf("Tecla 3 pressionada\n");
        // else if(ValorADC >= TECLA_4 - 50 && ValorADC <= TECLA_4 + 50)
        //     printf("Tecla 4 pressionada\n");
        // else if(ValorADC >= TECLA_5 - 50 && ValorADC <= TECLA_5 + 50)
        //     printf("Tecla 5 pressionada\n");
        // else if(ValorADC >= TECLA_6 - 50 && ValorADC <= TECLA_6 + 50)
        //     printf("Tecla 6 pressionada\n");
        // else if(ValorADC >= TECLA_7 - 50 && ValorADC <= TECLA_7 + 50)
        //     printf("Tecla 7 pressionada\n");
        // else if(ValorADC >= TECLA_8 - 50 && ValorADC <= TECLA_8 + 50)
        //     printf("Tecla 8 pressionada\n");
        // else if(ValorADC >= TECLA_9 - 50 && ValorADC <= TECLA_9 + 50)
        //     printf("Tecla 9 pressionada\n");
        // else if(ValorADC >= TECLA_0 - 50 && ValorADC <= TECLA_0 + 50)
        //     printf("Tecla 0 pressionada\n");
        // else if(ValorADC >= TECLA_A - 50 && ValorADC <= TECLA_A + 50)
        //     printf("Tecla A pressionada\n");
        // else if(ValorADC >= TECLA_B - 50 && ValorADC <= TECLA_B + 50)
        //     printf("Tecla B pressionada\n");
        // else if(ValorADC >= TECLA_C - 50 && ValorADC <= TECLA_C + 50)
        //     printf("Tecla C pressionada\n");
        // else if(ValorADC >= TECLA_D - 50 && ValorADC <= TECLA_D + 50)
        //     printf("Tecla D pressionada\n");
        // else if(ValorADC >= TECLA_E - 50 && ValorADC <= TECLA_E + 50)
        //     printf("Tecla E pressionada\n");
        // else if(ValorADC >= TECLA_F - 50 && ValorADC <= TECLA_F + 50)
        //     printf("Tecla F pressionada\n");
        // else
        //     printf("Nenhuma tecla pressionada\n");  

        int soma = 0;
        int i = 0;

        while (i < 10)
        {
            soma += adc1_get_raw(ADC1_CHANNEL_6);
            i++;
            vTaskDelay(100 / portTICK_PERIOD_MS);
        }

        int media = soma / 10;

        printf("media: %d\n", media);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}
