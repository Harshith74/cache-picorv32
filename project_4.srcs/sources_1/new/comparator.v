`timescale 1ns / 1ps


module comparatorTag #(parameter taglength = 4)
(input [taglength-1:0] inp1,inp2,
 input valid,validmem,
 output reg hitway);

always@(inp1,inp2)
    if(valid&&validmem)
    hitway <= inp1 == inp2;
    else
    hitway <= 0;
endmodule


module multiplecomp #(parameter noways = 4,taglength = 4)
(//input [taglength*noways-1:0] input1,
 input [taglength-1:0]inp1,inp2,inp3,inp4,
 input[noways-1:0] validarray,
 input [taglength-1:0]tag,
 input validmem,
 output hit,
 output reg[noways-1:0] sel);
 wire [noways-1:0] hitnoways;
comparatorTag comp1(inp1,tag,validarray[0],validmem,hitnoways[0]);
comparatorTag comp2(inp2,tag,validarray[1],validmem,hitnoways[1]);
comparatorTag comp3(inp3,tag,validarray[2],validmem,hitnoways[2]);
comparatorTag comp4(inp4,tag,validarray[3],validmem,hitnoways[3]);
assign hit = hitnoways[0] || hitnoways[1] || hitnoways[2] || hitnoways[3];

//always@(hitnoways)
//    case(hitnoways)
//    4'b0001: sel <= 2'b00;
//    4'b0010: sel <= 2'b01;
//    4'b0100: sel <= 2'b10;
//    4'b1000: sel <= 2'b11;
//    endcase
endmodule









