library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cron_dec is
    generic (
        CLOCK_FREQ : integer := 25_000_000
    );
    Port (
        clock    : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        conta    : in  STD_LOGIC;
        carga    : in  STD_LOGIC;
        chaves   : in  STD_LOGIC_VECTOR (6 downto 0);
        an       : OUT STD_LOGIC_VECTOR (3 downto 0);
        dec_ddp  : out STD_LOGIC_VECTOR (7 downto 0)
    );
end cron_dec;

architecture cron_dec of cron_dec is

    signal clk_1s: std_logic:='0';
	 
	 signal count_clk: INTEGER range 0 to CLOCK_FREQ - 1 := 0;
	 
	 signal min_int: Integer range 0 to 99 := 0;
	 
	 signal seg_int: integer range 0 to 59 := 0;
	  
	 signal Segundos_BCD, Minutos_BCD : std_logic_vector(7 downto 0);
	 signal d1, d2, d3, d4 : std_logic_vector(5 downto 0); 
	 
    type ROM is array (0 to 99) of std_logic_vector (7 downto 0); 
    constant conv_to_BCD : ROM := (
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

    type states is (IDL, LOAD, COUNT);
    signal EA, PE : states := IDL;

begin

	 P1: process(clock, reset)
    begin
         if reset = '1' then
              count_clk <= 0;
              clk_1s <= '0';
         elsif rising_edge(clock) then
              if count_clk = CLOCK_FREQ - 1 then
                    count_clk <= 0;
                    clk_1s <= not clk_1s;
              else
                    count_clk <= count_clk + 1;
              end if;
         end if;
    end process;    
	 
	 P2: process(clk_1s, reset)

    begin

        if reset = '1' then

            EA <= IDL;

        elsif rising_edge(clk_1s) then

            EA <= PE;

        end if;

    end process;
	 
	 P3: process(EA, carga, conta, min_int, seg_int)

    begin

        case EA is
            when IDL =>
                if carga = '1' then
                    PE <= LOAD;
                else
                    PE <= IDL;
                end if;

            when LOAD =>
                if conta = '1' then
                    PE <= COUNT;
                else
                    PE <= LOAD;
                end if;

            when COUNT =>
                if min_int = 0 and seg_int = 0 then
                    PE <= IDL;
                else
                    PE <= COUNT;
                end if;
        end case;

    end process;
    
	 
	 P4: process(clk_1s, reset)
     begin
         if reset = '1' then
              seg_int <= 0;
         elsif rising_edge(clk_1s) then
              if EA = IDL or EA = LOAD then
                    seg_int <= 0;
              elsif EA = COUNT then
                    if seg_int > 0 then
                         seg_int <= seg_int - 1;
                    elsif min_int > 0 then
                         seg_int <= 59;
                    else
                         seg_int <= 0;
                    end if;
              end if;
         end if;
     end process;
	  
    P5: process(clk_1s, reset)
     begin
         if reset = '1' then
              min_int <= 0;
         elsif rising_edge(clk_1s) then
              if EA = IDL then
                    min_int <= 0;
              elsif EA = LOAD then
                    min_int <= to_integer(unsigned(chaves));
              elsif EA = COUNT and seg_int = 0 and min_int > 0 then
                    min_int <= min_int - 1;
              end if;
         end if;
     end process;
	  
	  -- instanciação das ROMs

		Segundos_BCD <= conv_to_BCD(seg_int);
		Minutos_BCD <= conv_to_BCD(min_int);
		
		d4 <= '1' & Minutos_BCD(7 downto 4) & '1'; -- desliga ponto, ativa dígito
		d3 <= '1' & Minutos_BCD(3 downto 0) & '1';
		d2 <= '1' & Segundos_BCD(7 downto 4) & '1';
		d1 <= '1' & Segundos_BCD(3 downto 0) & '1';

		
display_driver : entity work.dspl_drv port map (
            clock      => clock,
            reset    => reset,
            d1   => d1,
            d2   => d2,
            d3   => d3,
            d4   => d4,
            an   => an,
            dec_ddp      => dec_ddp
		  );

end cron_dec;