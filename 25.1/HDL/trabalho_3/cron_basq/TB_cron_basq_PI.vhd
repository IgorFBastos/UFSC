LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_cron_basq_PI IS
END tb_cron_basq_PI;

ARCHITECTURE behavior OF tb_cron_basq_PI IS

    -- Component declaration for the Unit Under Test (UUT)
    COMPONENT cron_basq_PI
        GENERIC (MAXCOUNT : INTEGER := 10); -- Reduzido para simulação
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
    END COMPONENT;

    -- Inputs
    SIGNAL clk       : STD_LOGIC := '0';
    SIGNAL rst       : STD_LOGIC := '0';
    SIGNAL btn_start : STD_LOGIC := '0';
    SIGNAL btn_next  : STD_LOGIC := '0';
    SIGNAL btn_load  : STD_LOGIC := '0';
    SIGNAL in_quarto : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
    SIGNAL in_min    : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0011"; -- 3 minutos
    SIGNAL in_seg    : STD_LOGIC_VECTOR (1 DOWNTO 0) := "10";   -- 30 segundos

    -- Outputs
    SIGNAL out_quarto : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL out_min    : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL out_seg    : STD_LOGIC_VECTOR (5 DOWNTO 0);
    SIGNAL out_cent   : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL an         : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL dec_ddp    : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL leds       : STD_LOGIC_VECTOR (7 DOWNTO 0);

    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: cron_basq_PI
        GENERIC MAP (MAXCOUNT => 10)
        PORT MAP (
            clock => clk,
            reset => rst,
            para_continua => btn_start,
            novo_quarto => btn_next,
            carga => btn_load,
            c_quarto => in_quarto,
            c_minutos => in_min,
            c_segundos => in_seg,
            quarto => out_quarto,
            minutos => out_min,
            segundos => out_seg,
            centesimos => out_cent,
            an => an,
            dec_ddp => dec_ddp,
            leds => leds
        );

    -- Clock process definitions
    clk_process :PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 20 ns;
        rst <= '0';

        -- Load the initial values
        btn_load <= '1';
        WAIT FOR 20 ns;
        btn_load <= '0';

        -- Start countdown
        WAIT FOR 50 ns;
        btn_start <= '1';
        WAIT FOR 20 ns;
        btn_start <= '0';

        -- Simulate a pause
        WAIT FOR 1000 ns;
        btn_start <= '1';
        WAIT FOR 20 ns;
        btn_start <= '0';

        -- Simulate novo_quarto
        WAIT FOR 50 ns;
        btn_next <= '1';
        WAIT FOR 20 ns;
        btn_next <= '0';

        -- Wait more to observe behavior
        WAIT FOR 1000 ns;

        WAIT;
    END PROCESS;

END behavior;