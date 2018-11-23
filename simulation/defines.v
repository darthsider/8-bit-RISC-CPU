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

/////////////////////
/////////////////////
//STATE MACHINE CODES
`define fetch1 0 
`define fetch2 1 
`define decode 2 
`define NOT1 3
`define execute1 4
`define execute2 5
`define read1 6
`define write1 7
`define read2 8
`define write2 9
`define branch1 10
`define branch2 11
`define stop 12

//OPCODES     
`define NOP 0
`define ADD 1
`define SUB 2
`define AND 3
`define NOT 4
`define RD 5
`define WR 6
`define BR 7
`define BRZ 8

//General purpose registers
`define R0 0
`define R1 1
`define R2 2
`define R3 3
        
