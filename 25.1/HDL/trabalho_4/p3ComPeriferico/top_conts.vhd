LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- A entidade do nosso sistema completo. As portas são as conexões físicas da placa.
ENTITY top_conts IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        an : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
        dec_ddp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
    );
END top_conts;

ARCHITECTURE Behavioral OF top_conts IS

 
    SIGNAL wire_ce_cpu : STD_LOGIC;
    SIGNAL wire_rw_cpu : STD_LOGIC;
    SIGNAL wire_d_address_cpu : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL wire_data_out_cpu : STD_LOGIC_VECTOR(31 DOWNTO 0);


    SIGNAL wire_decimos : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wire_unidades : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wire_dezenas : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wire_centenas : STD_LOGIC_VECTOR(3 DOWNTO 0);
	 
	 SIGNAL d0, d1, d2, d3 : STD_LOGIC_VECTOR(5 DOWNTO 0);
    


BEGIN


   
    MIPS_SYSTEM_INST : ENTITY work.MIPS_S_withBRAMS
        PORT MAP(
            clock => clock,
            reset => reset,
            sel_CPU => '0',
            suspend => '0',
            ce_CPU => wire_ce_cpu,
            rw_CPU => wire_rw_cpu,
            d_address_CPU => wire_d_address_cpu,
            data_out_CPU => wire_data_out_cpu,
            suspend_ack => OPEN,
            bw_CPU => OPEN,
            ce_Per => '0',
            rw_Per => '0',
            bw_Per => '0',
            d_address_Per => (OTHERS => '0'),
            data_out_Per => (OTHERS => '0')
        );


    PERIFERICO_INST : ENTITY work.periferico
        PORT MAP(
            clock => clock,
            reset => reset,
            ce_CPU => wire_ce_cpu,
            rw_CPU => wire_rw_cpu,
            d_address_CPU => wire_d_address_cpu,
            data_out_CPU => wire_data_out_cpu,
            display_decimos => wire_decimos,
            display_unidades => wire_unidades,
            display_dezenas => wire_dezenas,
            display_centenas => wire_centenas
        );
		  
		  
	 d0 <= '1' & wire_decimos  & '1'; 
	 d1 <= '1' & wire_unidades & '1'; 
	 d2 <= '1' & wire_dezenas  & '1'; 
	 d3 <= '1' & wire_centenas & '1';

    DISPLAY_DRIVER_INST : ENTITY work.dspl_drv
        PORT MAP(
            clock => clock,
            reset => reset,
            d3 => d3,
            d2 => d2,
            d1 => d1,
            d0 => d0,
            an => an,
            dec_ddp => dec_ddp
        );

END Behavioral;