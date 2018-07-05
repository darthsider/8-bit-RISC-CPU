`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digitalvlsidesign.com
// Create Date: 20/05/2018  
// Design Name: Data Aquisition System
// Module Name: input_register 
//////////////////////////////////////////////////////////////////////////////////
module input_register(new_clk,reset,en,data_in,reg_out);

 input new_clk,reset;
 input en;
 input [1:0] data_in;
 output [1:0] reg_out;
 
 reg [1:0] reg_out;
 
 always @(posedge new_clk,posedge reset)
 begin
 if(reset)
 reg_out <= 0;
 else if(en)
 reg_out <= data_in;
 else
 reg_out <= reg_out;
 end
 
endmodule
