`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2020 14:44:45
// Design Name: 
// Module Name: comparator
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


module comparatorTag #(parameter taglength = 4)
(input [taglength-1:0] inp1,inp2,
 input valid,
 output reg hitway);

always@(inp1,inp2)
    if(valid)
    hitway <= inp1 == inp2;
    else
    hitway <= 0;
endmodule


module multiplecomp #(parameter noways = 4,taglength = 4)
(input [taglength-1:0]inp1,inp2,inp3,inp4,
 input[noways-1:0] validarray,
 input [taglength-1:0]tag,
 output hit,
 output [noways-1:0] hitnoways);
comparatorTag comp1(inp1,tag,validarray[0],hitnoways[0]);
comparatorTag comp2(inp2,tag,validarray[1],hitnoways[1]);
comparatorTag comp3(inp3,tag,validarray[2],hitnoways[2]);
comparatorTag comp4(inp4,tag,validarray[3],hitnoways[3]);
assign hit = hitnoways[0] || hitnoways[1] || hitnoways[2] || hitnoways[3];

//always@(hitnoways)
//    case(hitnoways)
//    4'b0001: sel <= 2'b00;
//    4'b0010: sel <= 2'b01;
//    4'b0100: sel <= 2'b10;
//    4'b1000: sel <= 2'b11;
//    endcase
endmodule









