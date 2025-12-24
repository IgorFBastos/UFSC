-------------------------------------------------------------------------------
--  The MIPS_S_withBRAMs Processing Subsystem
--		Last Release: 26/May/2025
--	Authors: 
--		Ney Calazans / Fernando Moraes
--
--	The MIPS_S_withBRAMs is a processing subsystem to implement the MIPS_S 
--		processor in several of Xilinx FPGAs (tested with Spartan3, 
--      Spartan-3E and Artyx-7 family FPGAs, others might be used).
--	This Hw instantiates:
--		1 - The MIPS_S processor.
--		2 - A 512 32-bit word program memory for it (using a single 16-Kbit 
--			BRAM module).
--		3 - An 8-Kbyte data memory (using four 16-Kbit BRAM modules to 
--			implement an interleaved memory architecture supporting single 
--          byte or four bytes read/write operations in a single cycle).
--          Future support for half-word (16-bit read/write) operations
--          is simple to add, but since MIPS_S does not implement neither
--          LH, LHU nor SH instructions, this is not necessary, for now.
--		4 - Glue logic to connect/adapt components 1/2/3 above and an 
--          external interface to accomodate a peripheral that might read
--			from or write to the data memory and process information 
--			contained therein. 
--
--	Last updates:
--	14/02/2025 - Correction of bugs in the le_mars.c and in the automatically
--		software generated memory.vhd required changes in MIPS_S_withBRAMs. 
--		See details below
--	03/04/2025 (Ney Calazans)
--		- MIPS_S_withBRAMS E/A migrated to a separate file
--  26/04/2025 (Ney Calazans)
--      - The fact that BRAMs are synchronous memories required attention, 
--          since the MIPS_S processor design initially assumed an
--          asynchronous memory interface was used. Also, when 
--          MIPS_S was first designed, inverted clock polarities were used
--          to drive the control unit (sensitive to the rising clock edge)
--          and the datapath (made sensitive to the falling clock edge).
--          This automatically acommodated the synchronous nature of BRAMs,
--          which is not the case now that all MIPS_S operations are 
--          executed on the rising edge of the clock only. To accomodate the
--          use of BRAMs in this new situation, one way is to invert the clock
--          polarity to use as BRAM clocks (it was necessary to do this 
--          for both Instruction and Data memories). To enable this, a new
--          signal (IDMem_clock) was created.
--      - Maybe there is an issue of clock efficiency. One possibility is 
--          that the synthesis correctly infers the need to buffer the clock
--          using a specific component such as a BUGP (for Xilinx FPGAs). If
--          this is not the case, we can instantiate a BUFGP explicitly
--          here (or anything equivalent, for other technologies). Decision
--          on what is the best approach to take depend on future performance
--          evaluation.
--  11/05/2025 (Ney Calazans)
--		- Several modifications to support the suspend/suspend_ack signals 
--			added to the MIPS_S
--  15/05/2025 (Ney Calazans)
--		- The design of the new peripheral  interface and the new glue logic
--			to support it is ready (currently under validation) 
--			1) The signal sel_CPU has been kept, mostly for 
--				back-compatibility, but it can be disregarded, since the 
--				new interface allows suspending and/or releasing the 
--				processor at any moment.
--			2) The new interface allows full control of the data memory
--				by the peripheral.
--			3) The whole behavior of the glue logic is controlled now by
--				the suspend_ack signal mainly. In the future this logic may 
--				also consider the address ranges in the d_address buses.
--			4) Two new generic parameters (LAST_I_ADDRESS and LAST_D_ADDRESS)
--				allow accomodating changes in the instruction
--				and data memory sizes, which default to 2 Kbytes for the 
--				instruction memory and 8 Kbytes for the data memory, keeping
--				unchanged the initial addresses for both memories.
--				For software using the stack, a good approach is initializing
--				$sp to the value LAST_D_ADDRESS+1, usually.
--  22/05/2025 (Ney Calazans) - bug fix
--		- The bw_RAM signal was not driven, now this has been corrected
--	26/05/2025 (Ney Calazans)
--		- Comments part has been updated
--  30/05/2025 (Ney Calazans)
--      - The generation of the Data Memory enable (ce_RAM) produced problems
--          when ignoring its address range checking, this has been corrected.
-------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.p_MIPS_S.all;  

entity MIPS_S_withBRAMs is
	generic(LAST_I_ADDRESS : wires32:=x"004007FF";
			LAST_D_ADDRESS : wires32:=x"10011FFF"); 
    port( -- First, the signals from/to the outside world, or not... 
		clock, reset, sel_CPU: in std_logic;
		reset_CPU: out std_logic;
	-- 	Now, the peripheral interface
	
		-- Inputs from the peripheral
		suspend, ce_Per, rw_Per, bw_Per: in std_logic;
		d_address_Per, data_out_Per: in wires32;
		
		-- Outputs to the peripheral
		suspend_ack, ce_CPU, rw_CPU, bw_CPU: out std_logic;
		d_address_CPU, data_out_CPU, data_out_RAM: out wires32
    );
end MIPS_S_withBRAMs;

architecture MIPS_S_withBRAMs of MIPS_S_withBRAMs is
	signal reset_CPU_int, valid_d_address: std_logic; -- CPU reset
	
	-- other 1-bit internal signals
	signal 	suspend_ack_int, ce_CPU_int, rw_CPU_int, bw_CPU_int,
			ce_RAM, rw_RAM, bw_RAM: std_logic;
	
	-- Several 32-bit internal signals
	signal 	i_address, instruction, data_out_CPU_int, data_in_RAM, 
			data_out_RAM_int, d_address_CPU_int : wires32;
	
	-- The size of the instruction and data memory addresses depend
	--		on their respective sizes. For now they are hardwired below
	signal	i_address_int: std_logic_vector(8 downto 0);
		-- The instruction memory address is only 9 bits long 
		--	corresponding to the bits (10 downto 2) from the
		--	32-bit address bus. It addresses up to 512 32-bit words
	signal	d_address_RAM: std_logic_vector(12 downto 0);
		-- The data memory address is only 13 bits long 
		--	corresponding to the bits (12 downto 0) from the
		--	32-bit address bus. It addresses up to 8192 8-bit words
	
	-- Signal to enable the correct operation of the 
    --  Instruction/Data memories when implemented with synchronous modules.
    signal IDMem_clock : std_logic;
    
 begin
	-- First, the reset logic
	reset_CPU_int <= reset or sel_CPU;
	reset_CPU <= reset_CPU_int;
    -- And the signal to drive the Instruction and Data memories
    --	The basic idea is just to invert the clock phase.
    Mem_Clock: IDMem_clock <= not clock;

	-- Second, the Instruction Memory
	--
	-- 1 BRAM (16 Kbits, 2Kbytes, 512 words) that contains the MIPS
	--		object code of the program to run
	--
	--	- Use the line below when running programs generated with PCSpim
	--		i_address_int <=  i_address(10 downto 2)-8;  
	--		-- takes out the 20H displacement
	--	- Use the line below when running programs generated with Mars
    i_address_int <=  i_address(10 downto 2);
    P_mem: entity work.program_memory
        port map(clock=>IDMem_clock, address=>i_address_int, 
				instruction=>instruction);

	-- Third, the MIPS_S(_Prt) in itself
	--
	I_MIPS_S: entity work.MIPS_S
		port map	(clock=>clock, reset=>reset_CPU_int, 
					ce=>ce_CPU_int, rw=>rw_CPU_int, bw=>bw_CPU_int,
					suspend=>suspend, suspend_ack=>suspend_ack_int,
					i_address=>i_address, instruction=>instruction,
					d_address=>d_address_CPU_int, data_in=>data_out_RAM_int,
					data_out=>data_out_CPU_int
					);

	-- Fourth, the glue logic to connect MIPS_S or the Peripheral to the
	--	Data Memory
	-- (20/05/2025) Address range checking added to the ce_RAM signal
	--     generation 
	I_Ctrl_Sigs:
	   valid_d_address <= '1' when (d_address_CPU_int >= x"10010000" and
		                           d_address_CPU_int < LAST_D_ADDRESS+1)
		                  else '0'; 
		ce_RAM <= ce_CPU_int when (valid_d_address='1' and
		                           suspend_ack_int='0') else
		          ce_Per when  (valid_d_address='1' and
		                        suspend_ack_int='1')  else
		          '0';  
		rw_RAM <= rw_CPU_int when (valid_d_address='1' and
		                           suspend_ack_int='0') else
		          rw_Per when  (valid_d_address='1' and
		                        suspend_ack_int='1')  else
		          '1';
		bw_RAM <= bw_CPU_int when (valid_d_address='1' and
		                           suspend_ack_int='0') else
		          bw_Per when  (valid_d_address='1' and
		                        suspend_ack_int='1')  else
		          '0';
	D_RAM_Addr_Mux:
		d_address_RAM <=	d_address_CPU_int(12 downto 0) 
								when (suspend_ack_int='0') else
							d_address_Per(12 downto 0);
	D_RAM_Data_Mux:
		data_in_RAM <=	data_out_CPU_int 
							when (suspend_ack_int='0') else
						data_out_Per;

	-- Fifth, the Data Memory
    --   
    -- 4 BRAMs (64 Kbits, 8 Kbytes) that will contain the MIPS program data
    --   
	D_mem: entity work.data_memory
		port map (clock=>IDMem_clock, ce=>ce_RAM, we=>rw_RAM, bw=>bw_RAM,
			address=>d_address_RAM(12 downto 2),
			byte_choice=>d_address_RAM(1 downto 0),
			data_in=>data_in_RAM, data_out=>data_out_RAM_int
			);
   
    d_address_CPU <= d_address_CPU_int;
	
	ce_CPU <= ce_CPU_int;
	rw_CPU <= rw_CPU_int;
	bw_CPU <= bw_CPU_int;
    
	data_out_CPU <= data_out_CPU_int;
	
	data_out_RAM <= data_out_RAM_int;
	
	suspend_ack <= suspend_ack_int;
    
end MIPS_S_withBRAMs;
