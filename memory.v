`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digitalvlsidesign.com
// Create Date: 20/05/2018 
// Design Name: Data Aquisition System
// Module Name: memory 
//////////////////////////////////////////////////////////////////////////////////
module memory(new_clk,reset,reg_out,read,write,inc,address,data_out,full);

 input new_clk,reset;
 input [1:0] reg_out;
 input read,write,inc;
 input [1:0] address;
 output [1:0] data_out;
 output full;
 
 reg [1:0] addr_ptr;
 reg [1:0] MEM [3:0];
 reg [1:0] data_out;
 reg inc_reg;
 wire inc_edge;

 
 always @(posedge new_clk,posedge reset)
 begin
 if(reset)
 inc_reg <= 0;
 else
 inc_reg <= inc;
 end
 
 assign inc_edge = ~inc_reg & inc;
 
 always @(posedge new_clk)
 begin
 if(inc_edge)
 addr_ptr <= addr_ptr + 1;
 end
 
 assign full = (addr_ptr == 2'b11) ? 1'b1 : 1'b0;
 
 always @(posedge new_clk)
 begin
 if(write)
 MEM[addr_ptr] <= reg_out;
 else if(read)
 data_out <= MEM[address];
 end

endmodule
