library verilog;
use verilog.vl_types.all;
entity risc_cpu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end risc_cpu;
