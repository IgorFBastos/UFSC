#include <stdio.h>
#include <driver/adc.h>
#include "freertos/FreeRTOS.h"

void app_main(void)
{
    // Define a resolução do ADC1.
    // ADC_WIDTH_BIT_12 => 12 bits => valores de 0 a 4095.
    // O ESP32 permite: 9, 10, 11 ou 12 bits.
    adc1_config_width(ADC_WIDTH_BIT_12);

    // Configura o canal do ADC e o nível de atenuação.
    // Aqui estamos configurando:
    //   - ADC1_CHANNEL_0  -> corresponde ao GPIO36.
    //   - ADC_ATTEN_DB_12 -> permite ler até aprox. 3.3V
    //
    // Sobre as attenuations:
    //   0 dB  →  até ~1.1V
    //   2.5 dB → até ~1.5V
    //   6 dB  → até ~2.2V
    //   11 dB → até ~3.3–3.6V (ideal para tensões de 3.3V)
    adc1_config_channel_atten(ADC1_CHANNEL_6, ADC_ATTEN_DB_0);

    while (1)
    {
        int val = adc1_get_raw(ADC1_CHANNEL_6);

        int soma = 0;
        int i = 0;

        while (i < 10)
        {
            soma += adc1_get_raw(ADC1_CHANNEL_6);
            i++;
            vTaskDelay(100 / portTICK_PERIOD_MS);
        }

        int media = soma / 10;
        printf("Lido %d\n", media);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}
