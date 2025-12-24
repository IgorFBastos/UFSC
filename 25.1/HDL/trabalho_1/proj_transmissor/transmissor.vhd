----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:56 05/03/2025 
-- Design Name: 
-- Module Name:    transmissor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transmissor is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           send : in  STD_LOGIC;
           palavra : in  STD_LOGIC_VECTOR (7 downto 0);
           busy : out  STD_LOGIC;
           linha : out  STD_LOGIC);
end transmissor;

architecture Behavioral of transmissor is

	type estado_type is (REPOUSO, START, TRANSMITE, STOP);
   signal estado_atual, estado_proximo : estado_type;
	
	signal contador : integer range 0 to 7 := 0;
   signal dado     : std_logic_vector(7 downto 0); 
   signal linha_reg: std_logic := '1';

begin
	
	-- Linha recebe linha_reg para n'ao ocorrer prblema de duplo drive(Boas praticas)
	linha <= linha_reg;
	
	-- Busy 1 para qualquer outro estado que nao seja REPOUSO
   busy  <= '1' when estado_atual /= REPOUSO else '0';
	
	-- Process para controlar o andamento dos estados, armazenar o dado e confuigurar o contador (SINCRONO) 
	process(clock, reset)
   begin
		-- Se o reset for ativo o sistema volta para 1 e o contador e zerado
		if reset = '1' then
			estado_atual <= REPOUSO;
         contador <= 0;
			
		-- Para cada borda de o estado atual e atulizado para o proximo estado calculado no outro processo
		elsif clock'event and clock = '1' then
			estado_atual <= estado_proximo;
			
			-- Se estiver no estado START copiamos o valor da palavra para o dado 
			if estado_atual = START then
				dado <= palavra;
         end if;
			
			-- Se estiver no estado TRANSMITE atualizamos o contador caso contrario zeramos ele
			if estado_atual = TRANSMITE then
				contador <= contador + 1;
         else
				contador <= 0;
         end if;
		end if;
    end process;
	 
	 
	 -- Process que contrala os estados
	 process(estado_atual, send, contador)
    begin
        case estado_atual is
		  
				-- Caso REPOUSO a linha fica em 1(default)
				-- Se send for para 1 avancamos o estado para START
				-- Caso contrario, o estado permance em REPOUSO
            when REPOUSO =>
				
                linha_reg <= '1';
                if send = '1' then
                    estado_proximo <= START;
                else
                    estado_proximo <= REPOUSO;
                end if;
				
				-- Caso START temos a linha indo para 0 indicando o inicio de uma transmissao 
				-- Avanca o estado para TRANSMITE
				when START =>
				
                linha_reg <= '0'; 
                estado_proximo <= TRANSMITE;
					 
				-- Caso TRANSMITE temos a nossa linha recebendo o bit do dado(palavra) MSB ate o LSB
				-- Se contador for igual a 7 avanca o estado para STOP 
				-- Caso contrario, o estado permance em TRANSMITE
				when TRANSMITE =>
				
                linha_reg <= dado(7 - contador);
                if contador = 7 then
                    estado_proximo <= STOP;
                else
                    estado_proximo <= TRANSMITE;
                end if;
					 
				-- Caso STOP temos a linha indo para 0 indicando o fim da transmissao
				-- Avanca o estado para REPOUSO
				when STOP =>
                linha_reg <= '0'; 
                estado_proximo <= REPOUSO;
        end case;
    end process;


end Behavioral;

