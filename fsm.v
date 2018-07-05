`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digitalvlsidesign.com
// Create Date: 20/05/2018  
// Design Name: Data Aquisition System
// Module Name: fsm
//////////////////////////////////////////////////////////////////////////////////
module fsm(new_clk,reset,load,en,inc,full,write,done);

 input new_clk,reset;
 input load,full;
 output en,inc,write,done;
 
 parameter [2:0] S0 = 3'b000,
                 S1 = 3'b001,
					  S2 = 3'b010,
					  S3 = 3'b011,
					  S4 = 3'b100,
					  S5 = 3'b101;
 
 reg en,inc,write,done;
 reg [2:0] state,next_state;
 reg load_reg;
 wire load_edge;
 
 
 always @(posedge new_clk,posedge reset)
 if(reset)
 begin
 state <= S0;
 load_reg <= 0;
 end
 else
 begin
 state <= next_state;
 load_reg <= load;
 end
 
 assign load_edge = ~load_reg & load;
 
 always @(*)
 begin
 next_state = state;
 en = 0; inc = 0; write = 0; done = 0;
 case(state)
 S0: begin
 if(load_edge)
 next_state = S1;
 else
 next_state = S0;
 end
 
 S1: begin
 en = 1;
 next_state = S2;
 end
 
 S2: begin
 write = 1;
 if(load_edge)
 next_state = S3;
 else
 next_state =  S2;
 end
 
 S3: begin
 en = 1;
 inc = 1;
 next_state = S4;
 end
 
 S4: begin
 write = 1;
 if(load_edge) 
 next_state = S3;
 else if(full)
 next_state = S5;
 else
 next_state = S4;
 end
 
 S5: begin
 done = 1;
 next_state = S0;
 end
 
 default: next_state = S0;
 endcase
 end
 
endmodule
