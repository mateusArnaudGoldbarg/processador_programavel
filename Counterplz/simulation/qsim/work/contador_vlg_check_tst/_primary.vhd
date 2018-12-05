library verilog;
use verilog.vl_types.all;
entity contador_vlg_check_tst is
    port(
        bcdout          : in     vl_logic_vector(6 downto 0);
        Output          : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end contador_vlg_check_tst;
