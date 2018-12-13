/*
 *  Copyright (C) 2018  Siddharth J <www.siddharth.pro>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
`include "defines.v"

module processor(clk,reset,Mem_IN,Mem_OUT,Mem_ADDR,write);

input clk,reset;

input [7:0] Mem_OUT;

output [7:0] Mem_IN,Mem_ADDR;
output write;

wire [3:0] sel_BUS;

wire zero; 
reg flag;
wire [7:0] instruction;

wire [3:0] opcode = instruction[7:4];

wire [7:0] alu_in1,alu_in2,alu_out;
wire [7:0] pc_OUT;
wire [7:0] R0_out,R1_out,R2_out,R3_out;
wire [7:0] bus;
              
reg [3:0] state, next_state;
reg load_OP1,load_OP2,load_AR,load_IR,load_flag,load_PC;
reg inc_PC,load_R0,load_R1,load_R2,load_R3;
reg error;
reg write; 

reg sel_MEM, sel_PC, sel_ALU;
reg sel_R0, sel_R1, sel_R2, sel_R3;

wire [1:0] src = instruction[3:2];
wire [1:0] dest = instruction[1:0];

ALU alu (alu_in1,alu_in2,opcode,zero,alu_out);
register OP1 (clk,reset,bus,load_OP1,alu_in1);
register OP2 (clk,reset,bus,load_OP2,alu_in2);
register IR (clk,reset,bus,load_IR,instruction);
register AR (clk,reset,bus,load_AR,Mem_ADDR);
program_counter PC (clk,reset,bus,load_PC,inc_PC,pc_OUT);
gp_registers GP (clk,reset,bus,load_R0,load_R1,load_R2,load_R3,R0_out,R1_out,R2_out,R3_out);


assign Mem_IN = bus;

assign sel_BUS = sel_MEM ? 3'b000 :
                  sel_R0 ? 3'b001 :
                  sel_R1 ? 3'b010 :
                  sel_R2 ? 3'b011 :
                  sel_R3 ? 3'b100 :
                  sel_PC ? 3'b101 :
                 sel_ALU ? 3'b110 : 3'bx;
       
assign bus = (sel_BUS == 3'b000) ? Mem_OUT :
             (sel_BUS == 3'b001) ? R0_out :
             (sel_BUS == 3'b010) ? R1_out :
             (sel_BUS == 3'b011) ? R2_out :
             (sel_BUS == 3'b100) ? R3_out :
             (sel_BUS == 3'b101) ? pc_OUT :
             (sel_BUS == 3'b110) ? alu_out : 'bx;       

always @(posedge clk) begin
if(reset) begin
flag <= 0;
end
else if(load_flag) begin
flag <= zero;
end
end
      
always @(posedge clk)
begin
if(reset) 
state <= `fetch1;
else
state <= next_state;
end
    
always @(state or opcode or src or dest or flag)
begin
load_OP1 = 0;
load_OP2 = 0;
load_PC = 0;
inc_PC = 0;
load_IR = 0;
load_AR = 0;
load_flag = 0;
load_R0 = 0;
load_R1 = 0;
load_R2 = 0;
load_R3 = 0;
sel_PC = 0;
sel_MEM = 0;
sel_ALU = 0;
sel_R0 = 0;
sel_R1 = 0;
sel_R2 = 0;
sel_R3 = 0;
write = 0;
error = 0;
next_state = state;
case(state)

`fetch1: begin
next_state = `fetch2;
sel_PC = 1;
load_AR = 1;
end //fetch1

`fetch2: begin
next_state = `decode;
sel_MEM =1;
load_IR = 1;
inc_PC = 1;
end //fetch2

`decode:
case(opcode)
`NOP: next_state = `fetch1;
`ADD,`SUB,`AND: begin
next_state = `execute1;
load_OP1 = 1;
case(src)
`R0: sel_R0 = 1;
`R1: sel_R1 = 1;
`R2: sel_R2 = 1;
`R3: sel_R3 = 1;
default: error = 1;
endcase
end
`NOT: begin
next_state = `NOT1;
load_OP1 = 1;
case(src)
`R0: sel_R0 = 1;
`R1: sel_R1 = 1;
`R2: sel_R2 = 1;
`R3: sel_R3 = 1;
default: error = 1;
endcase
end
`RD: begin
next_state = `read1;
sel_PC = 1;
load_AR = 1;
end
`WR: begin
next_state = `write1;
sel_PC = 1;
load_AR = 1;
end
`BR: begin
next_state = `branch1;
sel_PC = 1;
load_AR = 1;
end
`BRZ:if(flag == 1) 
begin
next_state = `branch1;
sel_PC = 1;
load_AR = 1;
end
else begin
next_state = `fetch1;
inc_PC = 1;
end

default: next_state = `stop;
endcase  //decode

`execute1: begin
next_state = `execute2;
load_OP2 = 1;
case(dest)
`R0: sel_R0 = 1;
`R1: sel_R1 = 1;
`R2: sel_R2 = 1;
`R3: sel_R3 = 1;
default: error = 1;
endcase
end //execute1

`execute2: begin
next_state = `fetch1;
sel_ALU = 1;
load_flag = 1;
case(dest)
`R0: load_R0 = 1;
`R1: load_R1 = 1;
`R2: load_R2 = 1;
`R3: load_R3 = 1;
default: error = 1;
endcase
end //execute2

`NOT1: begin
next_state = `fetch1;
sel_ALU = 1;
load_flag = 1;
case(dest)
`R0: load_R0 = 1;
`R1: load_R1 = 1;
`R2: load_R2 = 1;
`R3: load_R3 = 1;
default: error = 1;
endcase
end //NOT1

`read1: begin
next_state = `read2;
inc_PC = 1;
end //read1

`write1: begin
next_state = `write2;
sel_MEM = 1;
load_AR = 1;
inc_PC = 1;
end //write1

`read2: begin
next_state = `fetch1;
sel_MEM = 1; 
case(dest)
`R0: load_R0 = 1;
`R1: load_R1 = 1;
`R2: load_R2 = 1;
`R3: load_R3 = 1;
default: error = 1;
endcase
end //read2

`write2: begin
next_state = `fetch1;
write = 1;
case(src)
`R0: sel_R0 = 1;
`R1: sel_R1 = 1;
`R2: sel_R2 = 1;
`R3: sel_R3 = 1;
default: error = 1;
endcase
end //write2

`branch1: begin
next_state = `branch2;
sel_MEM = 1;
load_AR = 1;
end //branch1

`branch2: begin
next_state = `fetch1;
sel_MEM = 1;
load_PC = 1;
end //branch2

`stop: next_state = `stop;

default: next_state = `fetch1; 

endcase
end

endmodule



