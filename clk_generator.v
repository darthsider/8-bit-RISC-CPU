`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digitalvlsidesign.com
// Create Date: 20/05/2018 
// Design Name: Data Aquisition System
// Module Name: clk_generator 
//////////////////////////////////////////////////////////////////////////////////
module clk_generator(clk,new_clk);
  
  parameter N = 24; //500ms
  
  input clk;
  output new_clk;
  
  reg [N-1:0] count = 0;
  
  always @(posedge clk)
  begin
  count <= count + 1;
  end
  
  assign new_clk = count[N-1];

endmodule
