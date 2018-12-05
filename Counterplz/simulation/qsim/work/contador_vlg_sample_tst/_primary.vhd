library verilog;
use verilog.vl_types.all;
entity contador_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        enb             : in     vl_logic;
        rst             : in     vl_logic;
        s               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end contador_vlg_sample_tst;
