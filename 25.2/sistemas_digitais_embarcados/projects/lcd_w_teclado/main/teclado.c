#include "teclado.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"

// Mapa de teclas do teclado 4x4
const char keys[ROWS][COLS] = {
    {'1', '2', '3', 'A'},
    {'4', '5', '6', 'B'},
    {'7', '8', '9', 'C'},
    {'*', '0', '#', 'D'}
};

// Array com os pinos das linhas
const int row_pins[ROWS] = {R1, R2, R3, R4};

// Array com os pinos das colunas
const int col_pins[COLS] = {C1, C2, C3, C4};

// Inicializa os pinos do teclado
void init_teclado(void)
{
    // Configurar LINHAS como SAÍDA
    gpio_set_direction(R1, GPIO_MODE_OUTPUT);
    gpio_set_direction(R2, GPIO_MODE_OUTPUT);
    gpio_set_direction(R3, GPIO_MODE_OUTPUT);
    gpio_set_direction(R4, GPIO_MODE_OUTPUT);
    
    // Configurar COLUNAS como ENTRADA com PULL-UP
    gpio_set_direction(C1, GPIO_MODE_INPUT);
    gpio_set_pull_mode(C1, GPIO_PULLUP_ONLY);
    
    gpio_set_direction(C2, GPIO_MODE_INPUT);
    gpio_set_pull_mode(C2, GPIO_PULLUP_ONLY);
    
    gpio_set_direction(C3, GPIO_MODE_INPUT);
    gpio_set_pull_mode(C3, GPIO_PULLUP_ONLY);
    
    gpio_set_direction(C4, GPIO_MODE_INPUT);
    gpio_set_pull_mode(C4, GPIO_PULLUP_ONLY);
}

// Função para ler uma tecla pressionada
// Retorna o caractere da tecla ou '\0' se nenhuma tecla foi pressionada
char leiaTecla(void)
{
    for (int i = 0; i < ROWS; i++) {

        // Primeiro colocamos todas as linhas em nivel ato 
        gpio_set_level(R1, HIGH);
        gpio_set_level(R2, HIGH);
        gpio_set_level(R3, HIGH);
        gpio_set_level(R4, HIGH);

        // Agora colocamos a linha atual em LOW
        gpio_set_level(row_pins[i], LOW);

        for (int j = 0; j < COLS; j++) {
            // verifica se a coluna j está em low
            if (gpio_get_level(col_pins[j]) == LOW) {
                // Tecla pressionada encontrada
                // Retorna o caractere correspondente
                return keys[i][j];
            }
        } 
    }

    return '\0';  // Nenhuma tecla pressionada
}
