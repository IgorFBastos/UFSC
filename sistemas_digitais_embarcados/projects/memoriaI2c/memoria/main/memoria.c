#include <stdio.h>
#include "driver/i2c_master.h"
#include <inttypes.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include <unistd.h>



i2c_master_dev_handle_t dev_handle;
i2c_master_bus_handle_t bus_handle;
i2c_master_bus_config_t i2c_bus_config = {};
uint16_t end = 0x50;
i2c_device_config_t dev_cfg = {};

void aguardaTerminoOperacao()
{
	//Tenta mandar uma mensagem para o dispositivo. Se ele nao responder  (o ACK será=1) é por que está ocupado
	// Se estiver livre (ACK=0), retorna ESP_OK

	while (i2c_master_probe(bus_handle, 0x50 ,-1) != ESP_OK ) usleep(100);
}
void escreveByte(uint16_t posicao, uint8_t valor)
{
	//  A operacao de escrita é demorada, se uma outra operação foi tentada na sequencia, nao será execucutada pois o dispositivo está ocupado
	uint8_t v[3];
	v[0] = posicao >> 8;
	v[1] = posicao;
	v[2] = valor;

	// Faz a escrita de 1 byte

	// Antes de escrever, testa se por acaso se a memória não está ocupada
	aguardaTerminoOperacao();
	i2c_master_transmit(dev_handle, v, 3, -1);
	//Espera até a operação terminar e a memória ficar livre
	aguardaTerminoOperacao();


}

uint8_t leByte(uint16_t posicao)
{
	uint8_t resultado;
	uint8_t v[2];
	v[0] = (posicao >> 8) & 0xff;
	v[1] = (posicao & 0xff);
	i2c_master_transmit_receive(dev_handle, v, 2, &resultado, 1, -1);
	return resultado;

}
void app_main(void)
{
    i2c_bus_config.i2c_port = I2C_NUM_0;
	i2c_bus_config.sda_io_num = GPIO_NUM_4;
	i2c_bus_config.scl_io_num = GPIO_NUM_15;
	i2c_bus_config.clk_source = I2C_CLK_SRC_DEFAULT;
	i2c_bus_config.glitch_ignore_cnt=7;
	i2c_bus_config.flags.enable_internal_pullup = true;

	ESP_ERROR_CHECK(i2c_new_master_bus(&i2c_bus_config, &bus_handle));
	dev_cfg.dev_addr_length = I2C_ADDR_BIT_LEN_7;
	dev_cfg.device_address = 0x50;
	dev_cfg.scl_speed_hz = 100000;
	dev_cfg.scl_wait_us=0;
	dev_cfg.flags.disable_ack_check=1;

	ESP_ERROR_CHECK(i2c_master_bus_add_device(bus_handle, &dev_cfg, &dev_handle));
	uint8_t vet[200];

	printf("Escreve Bytes\n");
	for (int x=0;x<100;x++)
	{
		escreveByte(x, 50+x);
	}

	printf("Le bytes\n");
	for (int x=0;x<100;x++)
	{
		vet[x]=leByte(x);
	}
	printf("Mostra bytes\n");

	for (int x=0;x<100;x++)
	{
		printf("Lido [%d]=%d\n",x,vet[x]);
	}




}