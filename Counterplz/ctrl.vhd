library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity ctrl is
  port (rst_ctrl   : in STD_LOGIC;
        start_ctrl : in STD_LOGIC;
        clk_ctrl   : in STD_LOGIC; 
		  imm        : out std_logic_vector(3 downto 0);
		  alu_sct_ctrl		: out std_logic_vector(3 downto 0);
		  rf_sel_ctrl		: out std_logic_vector(1 downto 0);
		  rf_enb_ctrl		: out std_logic;
		  acc_enb_ctrl	: out std_logic;
		  IRd : out std_logic_vector(7 downto 0);
		  output_ctrl 	: out std_logic_vector(3 downto 0)
        );
end ctrl;

architecture fsm of ctrl is

  type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,done);
  signal state : state_type; 		
  signal irs : std_logic_vector(7 downto 0);
	
	--açoes do processador
	constant mova : std_logic_vector(3 downto 0) := "0000";
	constant movr : std_logic_vector(3 downto 0) := "0001";
	constant load : std_logic_vector(3 downto 0) := "0010";
	constant add  : std_logic_vector(3 downto 0) := "0011";
   constant sub  : std_logic_vector(3 downto 0) := "0100";
	constant andr : std_logic_vector(3 downto 0) := "0101";
   constant orr  : std_logic_vector(3 downto 0) := "0110";
   constant jmp  : std_logic_vector(3 downto 0) := "0111";
	constant inv  : std_logic_vector(3 downto 0) := "1000";
	constant halt : std_logic_vector(3 downto 0) := "1001";
	
	-- instruçoes do processador
	
	-- cada instruçao acrescentada devesse aumentar o numero do array
	type PM_BLOCK is array (0 to 4) of std_logic_vector(7 downto 0);
	constant PM : PM_BLOCK := (	

	-- Instruçoes do processador
		"00100010", --	load :   acc = 2	
		"00010100", --	movr :	r[01] = 0	
		"00100000", --	load :   acc = 0		
		"00010000", --	movr :	r[00] = 0		
		"00100001", --	load :   acc = 1
		"00110000", --	add  :	acc = i++
--		"01110000", -- jump
--		"00010000", --	movr :	
		
		
--		"00101001", --	load :   acc = 9

--		"01000000", -- sub  :   acc = 9 - 6
		
--		"00010000", --	movr :	r[00] = 3
		
		"10011111"  --	halt :	finaliza programa

     );
	  
begin
	process (rst_ctrl, clk_ctrl)
	-- these variables declared here don't change.
	-- these are the only data allowed inside
	-- our otherwise pure FSM
  
	variable IR : std_logic_vector(7 downto 0);
	variable OPCODE : std_logic_vector( 3 downto 0);
	variable ADDRESS : std_logic_vector (3 downto 0);
	variable PC : integer;
    
	begin
		if (rst_ctrl = '1') then
			state <= s0;
    
		elsif (clk_ctrl'event and clk_ctrl = '1') then			
    
      case (state) is
        
        when s0 =>    -- estado inicial
          PC := 0;  --inicializa as instruçoes
			 imm  <= "0000";
			 irs <= IR;
          if start_ctrl = '1' then
            state <= s1;
          else 
            state <= s0;
          end if;
          
        when s1 =>				-- busca as instruçoes
          IR := PM(PC);
          OPCODE := IR(7 downto 4);  --ação
          ADDRESS:= IR(3 downto 0);
--			 imm  <= ADDRESS;	 
          state <= s2;
			 irs <= IR;
        when s2 =>				-- incrementa o PC
          PC := PC + 1;
          state <= s3;
			 irs <= IR;
			
		  when s3 =>   -- codifica os estados da FSM
		  
		  		case (OPCODE) IS
					when mova 	=> state <= s4;
					when movr	=> state <= s5;         
					when load 	=> state <= s6;                                               
					when add  	=> state <= s7;			         
					when sub  	=> state <= s8;
					when andr 	=> state <= s9;
					when orr  	=> state <= s10;
					when jmp  	=> state <= s11;
					when inv  	=> state <= s12;
					when halt 	=> state <= s13;
					when others => state <= done;
				end case;
					irs <= IR;
          
        when s4 =>		--acc = r[]		
				acc_enb_ctrl <= '1';    --habilita o acumulador
				rf_enb_ctrl  <= '0';    --desabilita a escrita de dados no registrador
				alu_sct_ctrl  <= mova;  --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);  -- 1 e 0 serão carregados com 00
				state  <= s1;
				irs <= IR;
				
        when s5 =>    --r[] = acc
				acc_enb_ctrl <= '1';  --desabilita o acumulador
				rf_enb_ctrl  <= '1';  --desabilita a leitura de dado do registrador (rf)
				alu_sct_ctrl  <= movr;   --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);  --passado para o rf
				state <= s1;
				irs <= IR;
					
			when s6 =>    --acc = immediate
				imm  <= ADDRESS;
				acc_enb_ctrl <= '1';   --habilita o acumulador
				rf_enb_ctrl  <= '0';   --habilita a escrita de dados no registrador
				alu_sct_ctrl  <= load; --Diz a Alu o que deve ser feito
--				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;

			when s7 =>   --acc = acc + r[]
				acc_enb_ctrl <= '1';    --habilita o acumulador
				rf_enb_ctrl  <= '0';		--habilita a escrita de dados no registrador			 
				alu_sct_ctrl  <= add;   --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;

			when s8 =>    --acc = acc - r[]
				acc_enb_ctrl <= '1';    --habilita o acumulador
				rf_enb_ctrl  <= '0';		--habilita a escrita de dados no registrador			 
				alu_sct_ctrl  <= sub;	--Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;

			when s9 =>   -- acc = acc AND r[]
				acc_enb_ctrl <= '1';   --habilita o acumulador
				rf_enb_ctrl  <= '0';   --habilita a escrita de dados no registrador
				alu_sct_ctrl  <= andr; --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;
					
			when s10 =>   -- acc = acc OR r[]
				acc_enb_ctrl <= '1';    --habilita o acumulador
				rf_enb_ctrl  <= '0';    --habilita a escrita de dados no registrador
				alu_sct_ctrl  <= orr;   --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;
					
			when s11 =>   --PC = ADDRESS
				acc_enb_ctrl <= '0';    --desabilita o acumulador
				rf_enb_ctrl  <= '0';    --habilita a escrita de dados no registrador
				PC 	  		 := conv_integer(unsigned(ADDRESS));
				alu_sct_ctrl  <= jmp;   --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state   <= s1;
				irs <= IR;
					
			when s12 =>   --acc = NOTacc
				acc_enb_ctrl <= '0';    --desabilita o acumulador
				rf_enb_ctrl	 <= '0';    --habilita a escrita de dados no registrador
				alu_sct_ctrl  <= inv;   --Diz a Alu o que deve ser feito
				rf_sel_ctrl  <= ADDRESS(3 downto 2);
				state <= s1;
				irs <= IR;
					
			when s13 =>  --stop execution
				acc_enb_ctrl <= '0';    --desabilita o acumulador
				rf_enb_ctrl	 <= '0';    --habilita a escrita de dados no registrador
				state <=done;
				irs <= IR;
				
         when others =>
            state <= done;
				irs <= IR;
				
      end case;
		
    end if;
	 IRd <= irs;
  end process;	
  
end fsm;