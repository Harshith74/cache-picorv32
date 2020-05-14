`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2020 15:23:00
// Design Name: 
// Module Name: muxnto1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module muxnto1#(parameter muxlen = 4)(
input[31:0] in1,in2,in3,in4,
input[3:0] sel,//ideally should be number of ways or muxlength
input[3:0]wstrb,
output reg [31:0] muxout
);
always@(*)
if(wstrb == 0)
    case(sel)
    4'b0001: muxout <= in1;
    4'b0010: muxout <= in2;
    4'b0100: muxout <= in2;
    4'b1000: muxout <= in2;
    endcase
 endmodule
