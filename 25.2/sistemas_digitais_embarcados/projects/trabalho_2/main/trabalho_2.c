#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "driver/gpio.h"
#include "freertos/task.h"
#include "leitura.h"

#define D0 16
#define D1 17
#define D2 5
#define D3 18
#define D4 19
#define D5 21
#define D6 22
#define D7 23

#define NUM_AMOSTRAS 64


const uint8_t onda_quadrada[NUM_AMOSTRAS] = {
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};


const uint8_t onda_senoide[NUM_AMOSTRAS] = {
    128, 140, 153, 165, 177, 188, 199, 209, 219, 227, 234, 240, 245, 249, 252, 254,
    255, 254, 252, 249, 245, 240, 234, 227, 219, 209, 199, 188, 177, 165, 153, 140,
    128, 115, 102, 90, 78, 67, 56, 46, 36, 28, 21, 15, 10, 6, 3, 1,
    0, 1, 3, 6, 10, 15, 21, 28, 36, 46, 56, 67, 78, 90, 102, 115
};


const uint8_t onda_triangular[NUM_AMOSTRAS] = {
    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120,
    128, 136, 144, 152, 160, 168, 176, 184, 192, 200, 208, 216, 224, 232, 240, 248,
    255, 247, 239, 231, 223, 215, 207, 199, 191, 183, 175, 167, 159, 151, 143, 135,
    127, 119, 111, 103, 95, 87, 79, 71, 63, 55, 47, 39, 31, 23, 15, 7
};


const uint8_t onda_serra[NUM_AMOSTRAS] = {
    0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60,
    64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124,
    128, 132, 136, 140, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188,
    192, 196, 200, 204, 208, 212, 216, 220, 224, 228, 232, 236, 240, 244, 248, 252
};

void escrever_no_dac(uint8_t valor)
{
    gpio_set_level(D0, (valor >> 0) & 1);
    gpio_set_level(D1, (valor >> 1) & 1);
    gpio_set_level(D2, (valor >> 2) & 1);
    gpio_set_level(D3, (valor >> 3) & 1);
    gpio_set_level(D4, (valor >> 4) & 1);
    gpio_set_level(D5, (valor >> 5) & 1);
    gpio_set_level(D6, (valor >> 6) & 1);
    gpio_set_level(D7, (valor >> 7) & 1);
}

void rodar_onda(const uint8_t *vetor_da_onda)
{
    while (1)
    { 
        for (int i = 0; i < NUM_AMOSTRAS; i++)
        {
            // 1. Pega o valor do vetor
            uint8_t valor_atual = vetor_da_onda[i];

            printf("Valor atual da amostra: %d\n", valor_atual);

            // 2. Escreve nos pinos
            escrever_no_dac(valor_atual);
            
            // 3. Aguarda um tempo para controlar a frequência da onda
            vTaskDelay(1);
        }
    }
}

void app_main(void)
{

    // Inicializa a UART para as funções de leitura
    init_uart();

    // Configuração dos pinos dos dígitos como saída
    gpio_set_direction(D0, GPIO_MODE_OUTPUT);
    gpio_set_direction(D1, GPIO_MODE_OUTPUT);
    gpio_set_direction(D2, GPIO_MODE_OUTPUT);
    gpio_set_direction(D3, GPIO_MODE_OUTPUT);
    gpio_set_direction(D4, GPIO_MODE_OUTPUT);
    gpio_set_direction(D5, GPIO_MODE_OUTPUT);
    gpio_set_direction(D6, GPIO_MODE_OUTPUT);
    gpio_set_direction(D7, GPIO_MODE_OUTPUT);

    // Inicializar todos os pinos em estado conhecido
    gpio_set_level(D0, 0);
    gpio_set_level(D1, 0);
    gpio_set_level(D2, 0);
    gpio_set_level(D3, 0);
    gpio_set_level(D4, 0);
    gpio_set_level(D5, 0);
    gpio_set_level(D6, 0);
    gpio_set_level(D7, 0);

    char opcao;
    int valor_inicial;

    while (1)
    {
        printf("\n--- MENU ---\n");
        printf("[1] Gera onda quadrada\n");
        printf("[2] Gera onda senoide\n");
        printf("[3] Gera onda triangulo\n");
        printf("[4] Gera onda sera\n");
        printf("Escolha uma opcao: ");
        opcao = leiaB();
        switch (opcao)
        {
        case '1':
            printf("\nOnda Quadrada Selecionada!\n");
            rodar_onda(onda_quadrada); 
            break;
        case '2':
            printf("\nOnda Senoide Selecionada!\n");
            rodar_onda(onda_senoide);
            break;
        case '3':
            printf("\nOnda Triangular Selecionada!\n");
            rodar_onda(onda_triangular);
            break;
        case '4':
            printf("\nOnda Serra Selecionada!\n");
            rodar_onda(onda_serra);
            break;
        default:
            printf("Opcao invalida!\n");
            break;
        }
    }
}
