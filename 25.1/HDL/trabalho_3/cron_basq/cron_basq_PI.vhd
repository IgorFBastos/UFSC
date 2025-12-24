LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY cron_basq_PI IS
    GENERIC (MAXCOUNT : INTEGER := 500000);
    PORT (
        clock, reset : IN STD_LOGIC;
        para_continua, novo_quarto, carga : IN STD_LOGIC;
        c_quarto : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        c_minutos : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        c_segundos : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        quarto : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        minutos : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        segundos : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        centesimos : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        an : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        dec_ddp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        leds : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END cron_basq_PI;

ARCHITECTURE Behavioral OF cron_basq_PI IS
    SIGNAL Segundos_BCD, Centesimos_BCD : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL d0, d1, d2, d3 : STD_LOGIC_VECTOR(5 DOWNTO 0);

    TYPE ROM IS ARRAY (0 TO 99) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    CONSTANT conv_to_BCD : ROM := (
        "00000000", "00000001", "00000010", "00000011", "00000100",
        "00000101", "00000110", "00000111", "00001000", "00001001",
        "00010000", "00010001", "00010010", "00010011", "00010100",
        "00010101", "00010110", "00010111", "00011000", "00011001",
        "00100000", "00100001", "00100010", "00100011", "00100100",
        "00100101", "00100110", "00100111", "00101000", "00101001",
        "00110000", "00110001", "00110010", "00110011", "00110100",
        "00110101", "00110110", "00110111", "00111000", "00111001",
        "01000000", "01000001", "01000010", "01000011", "01000100",
        "01000101", "01000110", "01000111", "01001000", "01001001",
        "01010000", "01010001", "01010010", "01010011", "01010100",
        "01010101", "01010110", "01010111", "01011000", "01011001",
        "01100000", "01100001", "01100010", "01100011", "01100100",
        "01100101", "01100110", "01100111", "01101000", "01101001",
        "01110000", "01110001", "01110010", "01110011", "01110100",
        "01110101", "01110110", "01110111", "01111000", "01111001",
        "10000000", "10000001", "10000010", "10000011", "10000100",
        "10000101", "10000110", "10000111", "10001000", "10001001",
        "10010000", "10010001", "10010010", "10010011", "10010100",
        "10010101", "10010110", "10010111", "10011000", "10011001"
    );

    SIGNAL count_clk_to_1_cent : INTEGER RANGE 0 TO MAXCOUNT - 1 := 0;
    SIGNAL enable_1_cent : STD_LOGIC := '0';
    SIGNAL count_cent : INTEGER RANGE 0 TO 99 := 0;
    SIGNAL enable_1_seg : STD_LOGIC := '0';
    SIGNAL count_seg : INTEGER RANGE 0 TO 59 := 0;
    SIGNAL enable_1_min : STD_LOGIC := '0';
    SIGNAL count_min : INTEGER RANGE 0 TO 15 := 15;
    SIGNAL enable_1_quarter : STD_LOGIC := '0';
    SIGNAL count_quarter : INTEGER RANGE 0 TO 4 := 0;
    SIGNAL enable_finish_game : STD_LOGIC := '0';

    TYPE states IS (REP, CONTA, PARADO, LOAD);
    SIGNAL EA : states;
    SIGNAL prox_estado : states := REP;

    SIGNAL deb_para_continua, deb_novo_quarto, deb_carga : STD_LOGIC;

    SIGNAL int_minutos_vec : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_segundos_vec : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_centesimos_vec : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_quartos_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL novo_quarto_pedido : STD_LOGIC := '0';

BEGIN
    -- Divisor de clock
    P1 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            count_clk_to_1_cent <= 0;
        ELSIF rising_edge(clock) THEN
            IF count_clk_to_1_cent = MAXCOUNT - 1 THEN
                count_clk_to_1_cent <= 0;
                enable_1_cent <= '1';
            ELSE
                count_clk_to_1_cent <= count_clk_to_1_cent + 1;
                enable_1_cent <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- Contador de centésimos
    P2 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            count_cent <= 0;
            enable_1_seg <= '0';
        ELSIF novo_quarto_pedido = '1' THEN
            count_cent <= 0;
        ELSIF rising_edge(clock) THEN
            IF EA = LOAD AND deb_carga = '1' THEN
                count_cent <= 0;
            ELSIF EA = CONTA AND enable_1_cent = '1' THEN
                IF count_cent = 0 THEN
                    count_cent <= 99;
                    enable_1_seg <= '1';
                ELSE
                    count_cent <= count_cent - 1;
                    enable_1_seg <= '0';
                END IF;
            ELSE
                enable_1_seg <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- Contador de segundos
    P3 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            count_seg <= 0;
            enable_1_min <= '0';
        ELSIF novo_quarto_pedido = '1' THEN
            count_seg <= 0;
        ELSIF rising_edge(clock) THEN
            IF EA = LOAD AND deb_carga = '1' THEN
                CASE c_segundos IS
                    WHEN "00" => count_seg <= 0;
                    WHEN "01" => count_seg <= 15;
                    WHEN "10" => count_seg <= 30;
                    WHEN "11" => count_seg <= 45;
                    WHEN OTHERS => count_seg <= 0;
                END CASE;
            ELSIF EA = CONTA AND enable_1_seg = '1' THEN
                IF count_seg = 0 THEN
                    count_seg <= 59;
                    enable_1_min <= '1';
                ELSE
                    count_seg <= count_seg - 1;
                    enable_1_min <= '0';
                END IF;
            ELSE
                enable_1_min <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- Contador de minutos
    P4 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            count_min <= 15;
            enable_1_quarter <= '0';
        ELSIF novo_quarto_pedido = '1' THEN
            count_min <= 15;
        ELSIF rising_edge(clock) THEN
            IF EA = LOAD AND deb_carga = '1' THEN
                count_min <= TO_INTEGER(UNSIGNED(c_minutos));
            ELSIF EA = CONTA AND enable_1_min = '1' THEN
                IF count_min = 0 THEN
                    count_min <= 15;
                    enable_1_quarter <= '1';
                ELSE
                    count_min <= count_min - 1;
                    enable_1_quarter <= '0';
                END IF;
            ELSE
                enable_1_quarter <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- Contador de quartos
    P5 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            count_quarter <= 0;
            enable_finish_game <= '0';
        ELSIF rising_edge(clock) THEN
            novo_quarto_pedido <= '0';
            IF EA = LOAD AND deb_carga = '1' THEN
                count_quarter <= TO_INTEGER(UNSIGNED(c_quarto));
            ELSIF EA = PARADO AND deb_novo_quarto = '1' AND enable_1_quarter = '0' THEN
                IF count_quarter < 4 THEN
                    count_quarter <= count_quarter + 1;
                    enable_finish_game <= '0';
                    novo_quarto_pedido <= '1';
                ELSE
                    enable_finish_game <= '1';
                END IF;
            ELSIF EA = CONTA AND enable_1_quarter = '1' THEN
                IF count_quarter < 4 THEN
                    count_quarter <= count_quarter + 1;
                    enable_finish_game <= '0';
                ELSE
                    enable_finish_game <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- Máquina de estados (atualização do estado)
    P6 : PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            EA <= REP;
        ELSIF rising_edge(clock) THEN
            EA <= prox_estado;
        END IF;
    END PROCESS;

    -- Lógica da máquina de estados com depuração
    P7 : PROCESS (EA, deb_para_continua, deb_carga, deb_novo_quarto, enable_1_quarter, count_quarter)
    BEGIN
        CASE EA IS
            WHEN REP =>
                IF deb_para_continua = '1' AND count_quarter < 4 THEN
                    prox_estado <= CONTA;
                ELSIF deb_carga = '1' THEN
                    prox_estado <= LOAD;
                ELSE
                    prox_estado <= REP;
                END IF;
            WHEN CONTA =>
                IF deb_para_continua = '1' OR enable_1_quarter = '1' THEN
                    prox_estado <= PARADO;
                ELSE
                    prox_estado <= CONTA;
                END IF;
            WHEN PARADO =>
                IF deb_para_continua = '1' AND enable_1_quarter = '0' THEN
                    prox_estado <= CONTA;
                ELSIF deb_carga = '1' THEN
                    prox_estado <= LOAD;
                ELSIF deb_novo_quarto = '1' AND enable_1_quarter = '0' THEN
                    prox_estado <= REP;
                ELSE
                    prox_estado <= PARADO;
                END IF;
            WHEN LOAD =>
                IF deb_para_continua = '1' THEN
                    prox_estado <= CONTA;
                ELSE
                    prox_estado <= LOAD;
                END IF;
        END CASE;
    END PROCESS;

    -- Leds Minutos
    PROCESS (count_min)
    BEGIN
        CASE count_min IS
            WHEN 0 => leds(3 DOWNTO 0) <= "0000";
            WHEN 1 => leds(3 DOWNTO 0) <= "0001";
            WHEN 2 => leds(3 DOWNTO 0) <= "0010";
            WHEN 3 => leds(3 DOWNTO 0) <= "0011";
            WHEN 4 => leds(3 DOWNTO 0) <= "0100";
            WHEN 5 => leds(3 DOWNTO 0) <= "0101";
            WHEN 6 => leds(3 DOWNTO 0) <= "0110";
            WHEN 7 => leds(3 DOWNTO 0) <= "0111";
            WHEN 8 => leds(3 DOWNTO 0) <= "1000";
            WHEN 9 => leds(3 DOWNTO 0) <= "1001";
            WHEN 10 => leds(3 DOWNTO 0) <= "1010";
            WHEN 11 => leds(3 DOWNTO 0) <= "1011";
            WHEN 12 => leds(3 DOWNTO 0) <= "1100";
            WHEN 13 => leds(3 DOWNTO 0) <= "1101";
            WHEN 14 => leds(3 DOWNTO 0) <= "1110";
            WHEN 15 => leds(3 DOWNTO 0) <= "1111";
            WHEN OTHERS => leds(3 DOWNTO 0) <= "0000";
        END CASE;
    END PROCESS;

    -- Leds Quartos
    PROCESS (count_quarter)
    BEGIN
        CASE count_quarter IS
            WHEN 0 => leds(7 DOWNTO 4) <= "0001";
            WHEN 1 => leds(7 DOWNTO 4) <= "0011";
            WHEN 2 => leds(7 DOWNTO 4) <= "0111";
            WHEN 3 => leds(7 DOWNTO 4) <= "1111";
            WHEN OTHERS => leds(7 DOWNTO 4) <= "0001";
        END CASE;
    END PROCESS;

    -- Instâncias do debounce
    a1 : ENTITY work.debounce
        GENERIC MAP(DIVISION_RATE => 4000000)
        PORT MAP(
            clock => clock,
            reset => reset,
            key => para_continua,
            debkey => deb_para_continua
        );
    a2 : ENTITY work.debounce
        GENERIC MAP(DIVISION_RATE => 4000000)
        PORT MAP(
            clock => clock,
            reset => reset,
            key => novo_quarto,
            debkey => deb_novo_quarto
        );
    a3 : ENTITY work.debounce
        GENERIC MAP(DIVISION_RATE => 4000000)
        PORT MAP(
            clock => clock,
            reset => reset,
            key => carga,
            debkey => deb_carga
        );

    -- Conexão dos contadores às saídas
    minutos <= STD_LOGIC_VECTOR(TO_UNSIGNED(count_min, 4));
    segundos <= STD_LOGIC_VECTOR(TO_UNSIGNED(count_seg, 6));
    centesimos <= STD_LOGIC_VECTOR(TO_UNSIGNED(count_cent, 7));
    quarto <= STD_LOGIC_VECTOR(TO_UNSIGNED(count_quarter, 2));
    Segundos_BCD <= conv_to_BCD(count_seg);
    Centesimos_BCD <= conv_to_BCD(count_cent);

    d3 <= '1' & Segundos_BCD(7 DOWNTO 4) & '1';
    d2 <= '1' & Segundos_BCD(3 DOWNTO 0) & '1';
    d1 <= '1' & Centesimos_BCD(7 DOWNTO 4) & '1';
    d0 <= '1' & Centesimos_BCD(3 DOWNTO 0) & '1';

    display_driver : ENTITY work.dspl_drv PORT MAP (
        clock => clock,
        reset => reset,
        d0 => d0,
        d1 => d1,
        d2 => d2,
        d3 => d3,
        an => an,
        dec_ddp => dec_ddp
        );

END Behavioral;