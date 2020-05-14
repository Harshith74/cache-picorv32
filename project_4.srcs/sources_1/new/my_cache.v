module mycache(
input clk,
input [3:0] wstrb,
input [31:0] address,
input valid_l1,
output reg [31:0] data,
output [31:0]mem_wdata,
output hit
); //reset change valid bits to 0

parameter setlength = 4;
parameter taglength = 32 - (setlength + 2);
parameter num_ways = 4;
parameter cache_line_length = 32 + 1 + taglength;
reg [cache_line_length:0] cache_way_0[0:2^setlength];
reg [cache_line_length:0] cache_way_1[0:2^setlength];
reg [cache_line_length:0] cache_way_2[0:2^setlength];
reg [cache_line_length:0] cache_way_3[0:2^setlength];
    
wire [setlength-1:0] set;

assign set = (address>>2) || (2^(setlength+1) - 1);
wire [cache_line_length:0] line_0 = cache_way_0[set];
wire [cache_line_length:0] line_1 = cache_way_1[set];
wire [cache_line_length:0] line_2 = cache_way_2[set];
wire [cache_line_length:0] line_3 = cache_way_3[set];

wire [taglength:0] tag_0 = line_0[1:taglength];
wire [taglength:0] tag_1 = line_1[1:taglength];
wire [taglength:0] tag_2 = line_2[1:taglength];
wire [taglength:0] tag_3 = line_3[1:taglength];

wire [taglength:0] tag = address[31:setlength + 1];
wire [num_ways-1:0] validarray = {line_0[0], line_1[0], line_2[0], line_3[0]};

wire [num_ways - 1:0] select; //select signal for mux

wire[31:0] data1,data2;
reg mem_valid;

multiplecomp mc_1(tag_0, tag_1, tag_2, tag_3, validarray, validmem, tag,valid_l1, hit, select);

muxnto1 m(line_0[31:0], line_1[31:0], line_2[31:0], line_3[31:0], select, wstrb, data);
        //go to memory and get data2
endmodule