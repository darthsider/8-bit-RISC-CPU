library verilog;
use verilog.vl_types.all;
entity gp_registers is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \in\            : in     vl_logic_vector(7 downto 0);
        load0           : in     vl_logic;
        load1           : in     vl_logic;
        load2           : in     vl_logic;
        load3           : in     vl_logic;
        out0            : out    vl_logic_vector(7 downto 0);
        out1            : out    vl_logic_vector(7 downto 0);
        out2            : out    vl_logic_vector(7 downto 0);
        out3            : out    vl_logic_vector(7 downto 0)
    );
end gp_registers;
