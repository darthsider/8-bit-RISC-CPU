library verilog;
use verilog.vl_types.all;
entity processor is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        Mem_IN          : out    vl_logic_vector(7 downto 0);
        Mem_OUT         : in     vl_logic_vector(7 downto 0);
        Mem_ADDR        : out    vl_logic_vector(7 downto 0);
        write           : out    vl_logic
    );
end processor;
