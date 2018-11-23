library verilog;
use verilog.vl_types.all;
entity memory is
    port(
        clk             : in     vl_logic;
        \IN\            : in     vl_logic_vector(7 downto 0);
        \OUT\           : out    vl_logic_vector(7 downto 0);
        ADDR            : in     vl_logic_vector(7 downto 0);
        write           : in     vl_logic
    );
end memory;
