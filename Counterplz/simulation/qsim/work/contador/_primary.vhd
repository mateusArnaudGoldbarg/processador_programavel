library verilog;
use verilog.vl_types.all;
entity contador is
    port(
        clk             : in     vl_logic;
        enb             : in     vl_logic;
        rst             : in     vl_logic;
        s               : in     vl_logic;
        Output          : out    vl_logic_vector(2 downto 0);
        bcdout          : out    vl_logic_vector(6 downto 0)
    );
end contador;
