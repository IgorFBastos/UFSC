
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY periferico IS
    PORT (
        clock         : IN  STD_LOGIC;
        reset         : IN  STD_LOGIC;
        ce_CPU        : IN  STD_LOGIC; -- '1' quando o CPU quer acessar a memória/periférico
        rw_CPU        : IN  STD_LOGIC; -- '0' para escrita, '1' para leitura

        d_address_CPU : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_out_CPU  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);

        display_decimos  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        display_unidades : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        display_dezenas  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        display_centenas : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END periferico;

ARCHITECTURE Behavioral OF periferico IS

    SIGNAL reg_decimos  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_unidades : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_dezenas  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_centenas : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    process (clock, reset)
    begin
        if (reset = '1') then
            reg_decimos  <= (others => '0');
            reg_unidades <= (others => '0');
            reg_dezenas  <= (others => '0');
            reg_centenas <= (others => '0');
        elsif rising_edge(clock) then
            -- Verifica se o processador está fazendo uma operação de ESCRITA
            -- ce_CPU='1' (chip enable) e rw_CPU='0' (write)
            if (ce_CPU = '1' and rw_CPU = '0') then
                
                case d_address_CPU is
                    -- Endereço 0x10008000
                    when x"10008000" => 
                        -- Pega os 4 bits menos significativos do barramento de dados
                        reg_decimos <= data_out_CPU(3 DOWNTO 0);

                    -- Endereço 0x10008001
                    when x"10008001" =>
                        reg_unidades <= data_out_CPU(3 DOWNTO 0);

                    -- Endereço 0x10008002
                    when x"10008002" =>
                        reg_dezenas <= data_out_CPU(3 DOWNTO 0);

                    -- Endereço 0x10008003
                    when x"10008003" =>
                        reg_centenas <= data_out_CPU(3 DOWNTO 0);

                    -- Se o endereço não for um dos nossos, não fazemos nada.
                    when others =>
                        null;
                end case;
                
            end if;
        end if;
    end process;


    display_decimos  <= reg_decimos;
    display_unidades <= reg_unidades;
    display_dezenas  <= reg_dezenas;
    display_centenas <= reg_centenas;

END Behavioral;

