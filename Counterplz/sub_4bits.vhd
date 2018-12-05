library ieee;
use ieee.std_logic_1164.all;

entity sub_4bits is port 
(
	a : in std_logic_vector(3 downto 0);
	b : in std_logic_vector(3 downto 0);
	
	cin : in std_logic;                  
	s   : out std_logic_vector(3 downto 0);  		
	cout : out std_logic       
);
end sub_4bits;

architecture hardware of sub_4bits is

--component FA port
--(
--	a,b,cin : in std_logic;
--	s,cout : out std_logic
--);
--end component;

signal cout_0to1 : std_logic;
signal cout_1to2 : std_logic;
signal cout_2to3 : std_logic;

signal n1 : integer range 0 to 9 :=0;
signal n2 : integer range 0 to 9 :=0;
signal res : integer range 0 to 9 :=0;
signal r : std_logic_vector(3 downto 0);

begin

--	FA_0 : FA port map(a => A(0), b => B(0), cin => cin, s => S(0), cout => cout_0to1);
--	FA_1 : FA port map(a => A(1), b => B(1), cin => cout_0to1, s => S(1), cout => cout_1to2);
--	FA_2 : FA port map(a => A(2), b => B(2), cin => cout_1to2, s => S(2), cout => cout_2to3);
--	FA_3 : FA port map(a => A(3), b => B(3), cin => cout_2to3, s => S(3), cout => cout);
	process (a,b)
	begin
	if (a = "0000") then
		n1 <= 0;
	elsif(a = "0001") then
		n1 <= 1;
	elsif(a = "0010") then
		n1 <= 2;
	elsif(a = "0011") then
		n1 <= 3;
	elsif(a = "0100") then
		n1 <= 4;
	elsif(a = "0101") then
		n1 <= 5;
	elsif(a = "0110") then
		n1 <= 6;
	elsif(a = "0111") then
		n1 <= 7;
	elsif(a = "1000") then
		n1 <= 8;
	elsif(a = "1001") then
		n1 <= 9;
	end if;
	
	if (b = "0000") then
		n2 <= 0;
	elsif(b = "0001") then
		n2 <= 1;
	elsif(b = "0010") then
		n2 <= 2;
	elsif(b = "0011") then
		n2 <= 3;
	elsif(b = "0100") then
		n2 <= 4;
	elsif(b = "0101") then
		n2 <= 5;
	elsif(b = "0110") then
		n2 <= 6;
	elsif(b = "0111") then
		n2 <= 7;
	elsif(b = "1000") then
		n2 <= 8;
	elsif(b = "1001") then
		n2 <= 9;
	end if;
	res <= n1 - n2;
	
	if (res = 0) then
		r <= "0000";
	elsif(res = 1) then
		r <= "0001";
	elsif(res = 2) then
		r <= "0010";
	elsif(res = 3) then
		r <= "0011";
	elsif(res = 4) then
		r <= "0100";
	elsif(res = 5) then
		r <= "0101";
	elsif(res = 6) then
		r <= "0110";
	elsif(res = 7) then
		r <= "0111";
	elsif(res = 8) then
		r <= "1000";
	elsif(res = 9) then
		r <= "1001";
	end if;
	s <= r;
	end process;

end hardware;