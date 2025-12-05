#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "driver/gpio.h"
#include "freertos/task.h"
#include "leitura.h"

// Pinos que configuram os digitos
#define DIG_0 17  // LSB
#define DIG_1 5
#define DIG_2 18
#define DIG_3 19 // MSB

// Pinos que configuram o display - 1: unidade | 2: Dezena
#define DISPLAY_unidade 22
#define DISPLAY_dezena 23

// Variáveis globais
volatile int contador = 0;
volatile int velocidade_contador_ms = 1000;
volatile int parar_contador = 0;

// Função auxiliar para escrever um dígito no display
// Envia código BCD (4 bits) para o CI decodificador 
void escreve_digito(int dig)
{
    if (dig < 0 || dig > 9) dig = 0; // Proteção: só aceita dígitos 0-9
    
    gpio_set_level(DIG_0, (dig >> 0) & 1); // Bit 0 (LSB)
    gpio_set_level(DIG_1, (dig >> 1) & 1); // Bit 1
    gpio_set_level(DIG_2, (dig >> 2) & 1); // Bit 2
    gpio_set_level(DIG_3, (dig >> 3) & 1); // Bit 3 (MSB)
}

// TASK: responsável por atualizar o display e fazer a multiplexação
void task_mux_display_e_escrita()
{
    while (1)
    {
        // Captura o valor atual do contador
        int valor_atual = contador;

        // Separar o número em unidade e dezena
        int unidade = valor_atual % 10;
        int dezena = valor_atual / 10;

        // Desabilitar ambos os displays primeiro para evitar ghost
        gpio_set_level(DISPLAY_unidade, 0);
        gpio_set_level(DISPLAY_dezena, 0);
        
        // Pequeno delay para garantir que displays estão desligados
        vTaskDelay(1 / portTICK_PERIOD_MS);

        // Exibir unidade no display 1
        escreve_digito(unidade);
        gpio_set_level(DISPLAY_unidade, 1); // Habilita display da unidade
        vTaskDelay(10 / portTICK_PERIOD_MS); // 10ms para visualização

        // Desabilitar displays antes da troca
        gpio_set_level(DISPLAY_unidade, 0);
        gpio_set_level(DISPLAY_dezena, 0);
        
        // Pequeno delay para garantir que displays estão desligados
        vTaskDelay(1 / portTICK_PERIOD_MS);

        // Exibir dezena no display 2
        escreve_digito(dezena);
        gpio_set_level(DISPLAY_dezena, 1); // Habilita display da dezena
        vTaskDelay(10 / portTICK_PERIOD_MS); // 10ms para visualização
    }
}

// TASK: responsável por incrementar o contador a cada segundo
void task_incrementa_contador()
{
    while (1)
    {
        if (parar_contador == 0)
        {
            contador++;
            if (contador > 99)
            {
                contador = 0; // Reinicia o contador após 99
            }
        }

        vTaskDelay(velocidade_contador_ms / portTICK_PERIOD_MS); // Incrementa a cada segundo
    }
}

void app_main(void)
{
    // Inicializa a UART para as funções de leitura
    init_uart();

    // Configuração dos pinos dos dígitos e do display como saída
    gpio_set_direction(DIG_0, GPIO_MODE_OUTPUT);
    gpio_set_direction(DIG_1, GPIO_MODE_OUTPUT);
    gpio_set_direction(DIG_2, GPIO_MODE_OUTPUT);
    gpio_set_direction(DIG_3, GPIO_MODE_OUTPUT);
    gpio_set_direction(DISPLAY_unidade, GPIO_MODE_OUTPUT);
    gpio_set_direction(DISPLAY_dezena, GPIO_MODE_OUTPUT);

    // Inicializar todos os pinos em estado conhecido
    gpio_set_level(DIG_0, 0);
    gpio_set_level(DIG_1, 0);TaskDelay(1 / portTICK_PERIOD_MS);
    gpio_set_level(DIG_2, 0);
    gpio_set_level(DIG_3, 0);
    gpio_set_level(DISPLAY_unidade, 0); // Displays desabilitados inicialmente
    gpio_set_level(DISPLAY_dezena, 0); // Display desabilitado inicialmente 

    // Criação das tasks
    xTaskCreate(task_mux_display_e_escrita, "task_mux_display_e_escrita", 2048, NULL, 1, NULL);
    xTaskCreate(task_incrementa_contador, "task_incrementa_contador", 2048, NULL, 1, NULL);

    char opcao;
    int valor_inicial;

    while (1)
    {
        vTaskDelay(1000 / portTICK_PERIOD_MS); 
        printf("\n--- MENU ---\n");
        printf("[1] Incrementa velocidade do contador\n");
        printf("[2] Decrementa velocidade do contador\n");
        printf("[3] Para o contador\n");
        printf("[4] Retorna a contagem\n");
        printf("[5] Informa valor inicial da contagem\n");
        printf("Escolha uma opcao: ");
        opcao = leiaB();
        switch (opcao)
        {
        case '1':
            if(velocidade_contador_ms > 100)
                velocidade_contador_ms -= 100;
            break;
        case '2':
            velocidade_contador_ms += 100;
            break;
        case '3':
            parar_contador = 1;
            break;
        case '4':
            parar_contador = 0;
            break;
        case '5':
            printf("Digite o valor inicial da contagem: ");
            valor_inicial = leiaInteiro();
            if (valor_inicial >= 0 && valor_inicial <= 99)
                contador = valor_inicial;
            else
                printf("Valor invalido! Deve estar entre 0 e 99.\n");

            break;
        default:
            printf("Opcao invalida!\n");
            break;
        }
    }
}
