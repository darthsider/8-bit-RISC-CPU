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

module memory(clk,IN,OUT,ADDR,write);

input clk,write;
input [7:0] IN;
input [7:0] ADDR;

output [7:0] OUT;

reg [7:0] MEM [255:0];

initial
begin
  $readmemb("testvalue.bin", MEM);
end

always @(posedge clk) 
begin
if(write)
MEM[ADDR] = IN;
end

assign OUT = MEM[ADDR];
 
endmodule
