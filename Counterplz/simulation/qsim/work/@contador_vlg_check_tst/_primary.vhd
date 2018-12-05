library verilog;
use verilog.vl_types.all;
entity Contador_vlg_check_tst is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        d               : in     vl_logic;
        e               : in     vl_logic;
        f               : in     vl_logic;
        g               : in     vl_logic;
        hex0            : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        IRds            : in     vl_logic_vector(7 downto 0);
        output_cpu      : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end Contador_vlg_check_tst;
