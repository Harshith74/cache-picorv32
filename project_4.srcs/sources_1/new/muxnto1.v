`timescale 1ns / 1ps

module muxnto1#(parameter muxlen = 4)(
input clk,
input[31:0] in1,in2,in3,in4,
input[3:0] sel,//ideally should be number of ways or muxlength
input[3:0]wstrb,
output reg [31:0] muxout
);
always@(posedge clk)
if(wstrb == 0)
    case(sel)//sel = 0000 implies miss and nothing happens
    4'b0001: muxout <= in1;
    4'b0010: muxout <= in2;
    4'b0100: muxout <= in2;
    4'b1000: muxout <= in2;
    endcase
 endmodule
