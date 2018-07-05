`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digitalvlsidesign.com
// Create Date: 20/05/2018 
// Design Name: Data Aquisition System
// Module Name: das 
//////////////////////////////////////////////////////////////////////////////////
module das(clk,reset,data_in,read,address,load,data_out,done);

  input clk,reset;
  input [1:0] data_in;
  input load,read;
  input [1:0] address;
  output [1:0] data_out;
  output done;
  
  wire new_clk;
  wire [1:0] reg_out;
  wire en,inc,write,full;
  
  clk_generator U0 (clk,new_clk);
  input_register U1 (new_clk,reset,en,data_in,reg_out);
  memory U2 (new_clk,reset,reg_out,read,write,inc,address,data_out,full);
  fsm U3 (new_clk,reset,load,en,inc,full,write,done);

endmodule
