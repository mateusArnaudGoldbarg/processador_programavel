library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- these should probably stay the same
entity Contador is
   port (rst_cpu: in STD_LOGIC;
    	   start_cpu: in STD_LOGIC;
         clk_cpu: in STD_LOGIC;
	      output_cpu: out STD_LOGIC_VECTOR (3 downto 0);
       	a,b,c,d,e,f,g: out std_logic;
			IRds : out std_logic_vector(7 downto 0);
			hex3, hex2, hex1, hex0: out std_logic_vector (6 downto 0)
			);
end Contador;

architecture struc of Contador is

--Display de instrucao
component bcd7seg
 port (instrucoes: in std_logic_vector (3 downto 0);
		 hex3, hex2, hex1, hex0: out std_logic_vector (6 downto 0)
		 );
end component;

--Bloco de controle
component ctrl 
  port (rst_ctrl     : in STD_LOGIC;
        start_ctrl   : in STD_LOGIC;
        clk_ctrl     : in STD_LOGIC;   
		  imm        : out std_logic_vector(3 downto 0);		  
		  alu_sct_ctrl	: out std_logic_vector(3 downto 0);
		  rf_sel_ctrl	: out std_logic_vector(1 downto 0);
		  rf_enb_ctrl	: out std_logic;
		  acc_enb_ctrl	: out std_logic;
		  IRd : out std_logic_vector(7 downto 0);
		  output_ctrl 	: out std_logic_vector(3 downto 0)
        );
end component;

--Datapath
component dp
  port (rst_dp     : in STD_LOGIC;
        clk_dp     : in STD_LOGIC;
        input_dp   : in std_logic_vector(3 downto 0);
        alu_sct_dp : in std_LOGIC_VECTOR (3 downto 0);
		  rf_sel_dp  : in std_LOGIC_VECTOR (1 downto 0);
		  rf_enb_dp  : in std_LOGIC;
		  acc_enb_dp : in std_LOGIC;
		  ime        : in std_logic_vector (3 downto 0);
		  output_dp  : out STD_LOGIC_VECTOR (3 downto 0)
        );
end component;

signal end_cpu             :  std_logic_vector(3 downto 0);
signal immediate           :  std_logic_vector(3 downto 0);
signal cpu_out             :  std_logic_vector(3 downto 0);
signal output_ctrl_out 		:  std_logic_vector(3 downto 0);	
signal alu_sct_ctrl_out 	:  std_logic_vector(3 downto 0); 
signal rf_sel_ctrl_out 		:  std_logic_vector(1 downto 0);   
signal rf_enb_ctrl_out 		:  std_logic;						  
signal acc_enb_ctrl_out 	:  std_logic;
signal ir_display 		   : std_logic_vector (7 downto 0);

begin

  controller: ctrl port map(rst_cpu, start_cpu, clk_cpu, immediate, alu_sct_ctrl_out, rf_sel_ctrl_out, rf_enb_ctrl_out, acc_enb_ctrl_out,ir_display, end_cpu);
  datapath: dp port map(rst_cpu, clk_cpu, end_cpu, alu_sct_ctrl_out, rf_sel_ctrl_out, rf_enb_ctrl_out, acc_enb_ctrl_out,immediate, cpu_out);
  bcd7seg_com: bcd7seg port map (alu_sct_ctrl_out, hex3, hex2, hex1, hex0);
  
  process(rst_cpu, clk_cpu)
  begin

	 if (rst_cpu = '1') then
		a <= '0'; 
      b <= '0'; 
		c <= '0'; 
		d <= '0'; 
      e <= '0'; 
		f <= '0'; 
		g <= '1';

    elsif(clk_cpu'event and clk_cpu='1') then
    output_cpu <= cpu_out;
       case (cpu_out) is
		 
         when "0000" => --0
           a <= '0';
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
			  e <= '0'; 
			  f <= '0'; 
			  g <= '1';
			  
         when "0001" => --1
           a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
			  e <= '1'; 
			  f <= '1'; 
			  g <= '1';
			  
         when "0010" => --2
			  a <= '0'; 
			  b <= '0'; 
			  c <= '1'; 
			  d <= '0'; 
			  e <= '0'; 
			  f <= '1'; 
			  g <= '0';
			  
         when "0011" => --3
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
			  e <= '1'; 
			  f <= '1'; 
			  g <= '0';
			  
         when "0100" => --4
           a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
			  e <= '1'; 
			  f <= '0'; 
			  g <= '0';
			  
         when "0101" => --5
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
			  e <= '1'; 
			  f <= '0'; 
			  g <= '0';
			  
         when "0110" => --6
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
			  e <= '0'; 
			  f <= '0'; 
			  g <= '0';
			  
         when "0111" => --7
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
			  e <= '1'; 
			  f <= '1'; 
			  g <= '1';
			  
         when "1000" => --8
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
			  e <= '0'; 
			  f <= '0'; 
			  g <= '0';
			  
         when "1001" => --9
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
			  e <= '1'; 
			  f <= '0'; 
			  g <= '0';
			  
         when others => --others
			  a <= '1'; 
			  b <= '1'; 
			  c <= '1'; 
			  d <= '1'; 
			  e <= '1'; 
			  f <= '1'; 
			  g <= '1';
			  
       end case;
		 
    end if;
	 IRds <= ir_display;
  end process;	
  
end struc;