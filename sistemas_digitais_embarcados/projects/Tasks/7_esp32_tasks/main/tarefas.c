
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
#include "esp_log.h"

#define VERMELHO 23
#define AMARELO 22
#define LOW 0
#define HIGH 1

volatile uint32_t vv;

// Tarefa faz dois leds ficarem piscando e velocidades diferentes

// Função da tarefa
void led_amarelo(void *pvParameter)
{
	// Loop infinito
	while (1)
	{
		// Delay de 1 segundo - Faz com que ess tarefa fica suspensa por 1 segundo, enquanto isso outras tarefas podem rodar
		vTaskDelay(1000 / portTICK_PERIOD_MS);
		// Liga o led
		gpio_set_level(AMARELO, HIGH);
		// Delay de 1 segundo
		vTaskDelay(1000 / portTICK_PERIOD_MS);
		// Desliga o led
		gpio_set_level(AMARELO, LOW);
	}
}
void led_vermelho(void *pvParameter)
{
	while (1)
	{
		vTaskDelay(200 / portTICK_PERIOD_MS);
		gpio_set_level(VERMELHO, HIGH);
		vTaskDelay(200 / portTICK_PERIOD_MS);
		gpio_set_level(VERMELHO, LOW);
	}
}
void app_main()
{
	// Configuração dos pinos
	gpio_reset_pin(VERMELHO);
	gpio_set_direction(VERMELHO, GPIO_MODE_OUTPUT);

	gpio_reset_pin(AMARELO);
	gpio_set_direction(AMARELO, GPIO_MODE_OUTPUT);

	// Criação das tarefas
	// parametros do xTaskCreatePinnedToCore
	// Ponteiro para a função que implementa a tarefa
	// Nome da tarefa (para debug, pode ser NULL)
	// Tamanho da pilha onde é alocado a tarefa
	// Parâmetro que pode ser passado para a tarefa (pode ser NULL)
	// Prioridade da tarefa (0 a 25)
	// Ponteiro para a tarefa (pode ser NULL)
	// Núcleo onde a tarefa será executada (0 ou 1) -1 para qualquer núcleo

	xTaskCreatePinnedToCore(led_vermelho, "tarefa_1", 2048, NULL, 1, NULL, 1);
	xTaskCreatePinnedToCore(led_amarelo, "tarefa_2", 2048, NULL, 2, NULL, 1);
}
