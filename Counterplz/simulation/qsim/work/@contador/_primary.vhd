library verilog;
use verilog.vl_types.all;
entity Contador is
    port(
        rst_cpu         : in     vl_logic;
        start_cpu       : in     vl_logic;
        clk_cpu         : in     vl_logic;
        output_cpu      : out    vl_logic_vector(3 downto 0);
        a               : out    vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        d               : out    vl_logic;
        e               : out    vl_logic;
        f               : out    vl_logic;
        g               : out    vl_logic;
        IRds            : out    vl_logic_vector(7 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0)
    );
end Contador;
