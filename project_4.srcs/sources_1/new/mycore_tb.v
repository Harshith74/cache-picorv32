`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2020 14:19:07
// Design Name: 
// Module Name: mycore_tb
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

/*input clk,
input [3:0] wstrb,
input [31:0] address,
output [31:0] data*/
module mycore_tb;
      reg clk;
      reg[3:0] wstrb;
      reg[31:0] address;
      wire[31:0] data;
      reg valid_l1;
      
      mycache cache1(
      .clk(clk),
      .wstrb(wstrb),
      .address(address),
      .data(data),
      .valid_l1(valid_l1));
      
      always
        #5
        clk = ~clk;
      initial begin
        clk = 0;
        wstrb = 4'b0000;
        address = 0;
        valid_l1 = 1;
      end
      
      always
      address = address + 4;
      
      
      
endmodule
