library verilog;
use verilog.vl_types.all;
entity Contador_vlg_sample_tst is
    port(
        clk_cpu         : in     vl_logic;
        rst_cpu         : in     vl_logic;
        start_cpu       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Contador_vlg_sample_tst;
