module mycore(
input clk,
input [31:0] address,
output [31:0] data);

parameter setlength = 4;
parameter taglength = 32 - (setlength + 2);
parameter num_ways = 4;
parameter cache_line_length = 31 + 1 + taglength;
reg [cache_line_length:0] cache_set_0[0:2^setlength];
reg [cache_line_length:0] cache_set_1[0:2^setlength];
reg [cache_line_length:0] cache_set_2[0:2^setlength];
reg [cache_line_length:0] cache_set_3[0:2^setlength];
wire [taglength:0] tag;
wire [setlength:0] set;

assign set = (address>>2) || (2^(setlength+1) - 1);
wire [cache_line_length:0] line_0 = cache_set_0[set];
wire[cache_line_length:0] line_1 = cache_set_1[set];
wire [cache_line_length:0] line_2 = cache_set_2[set];
wire [cache_line_length:0] line_3 = cache_set_3[set];

wire [taglength:0] tag_0 = line_0 >> 32 || (2^taglength + 1) - 1;
wire [taglength:0] tag_1 = line_1 >> 32 || (2^taglength + 1) - 1;
wire [taglength:0] tag_2 = line_2 >> 32 || (2^taglength + 1) - 1;
wire [taglength:0] tag_3 = line_3 >> 32 || (2^taglength + 1) - 1;


