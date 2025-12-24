LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY prim_proc_TB IS
END prim_proc_TB;
 
ARCHITECTURE behavior OF prim_proc_TB IS 
 
 
    COMPONENT prim_proc
    PORT(
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         in3 : IN  std_logic;
         in4 : IN  std_logic;
         ctrl : IN  std_logic_vector(1 downto 0);
         sai : OUT  std_logic
			
        );
    END COMPONENT;
    

   signal in1 : std_logic := '0';
   signal in2 : std_logic := '0';
   signal in3 : std_logic := '0';
   signal in4 : std_logic := '0';
   signal ctrl : std_logic_vector(1 downto 0) := (others => '0');

   signal sai : std_logic;
	

 
 BEGIN

        uut: prim_proc port map (
        in1 => in1,
        in2 => in2,
        in3 => in3,
        in4 => in4,
        ctrl => ctrl,
        sai => sai

    );


    
    stim_proc: process
    begin
		in1 <= '0';
		in2 <= '0';
		in3 <= '0';
		in4 <= '0';
		ctrl <= "00";
		wait for 5ns; --5
		ctrl <= "01";
		wait for 5ns; --10
		in2 <= '1';
		wait for 5ns; --15
		in4 <= '1';
		wait for 5ns; --20
		in1 <= '1';
		wait for 5ns; --25
		in3 <= '1';
		wait for 5ns; --30
		in2 <= '0';
		wait for 5ns; --35
		in4 <= '0';
		wait for 5ns; --40
		in1 <= '0';
		wait for 3ns; --43
		in3 <= '0';
		wait for 2ns;  --45
		ctrl <= "10";
		wait for 3ns;  --48
		in2 <= '1';
		wait for 2ns;  --50
		in4 <= '1';
		wait for 5ns;  --55
		in1 <= '1';
		wait for 3ns;  --58
		in3 <= '1';
		wait for 5ns;  --60
		ctrl <= "11";
		wait for 1ns;  --61
		in2 <= '0';
		wait for 3ns;  --63
		ctrl <= "00";
		wait for 3ns;  --66
		in1 <= '0';
		wait for 4ns;  --70
		in4 <= '0';
		wait for 5ns;  --75
		ctrl <= "01";

		wait;
    end process;
 

END;
