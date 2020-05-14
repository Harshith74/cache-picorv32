module mycache_withmem(
input clk,
input [3:0] wstrb,
input [31:0] address,
input valid_l1,
output reg [31:0] data,
output [31:0]mem_wdata,
output reg mem_ready); //reset change valid bits to 0

//parameter setlength = 4;
//parameter taglength = 32 - (setlength + 2);
//parameter num_ways = 4;
//parameter cache_line_length = 32 + 1 + taglength;
//reg [cache_line_length:0] cache_way_0[0:2^setlength];
//reg [cache_line_length:0] cache_way_1[0:2^setlength];
//reg [cache_line_length:0] cache_way_2[0:2^setlength];
//reg [cache_line_length:0] cache_way_3[0:2^setlength];
    
//wire [setlength-1:0] set;

//assign set = (address>>2) || (2^(setlength+1) - 1);
//wire [cache_line_length:0] line_0 = cache_way_0[set];
//wire [cache_line_length:0] line_1 = cache_way_1[set];
//wire [cache_line_length:0] line_2 = cache_way_2[set];
//wire [cache_line_length:0] line_3 = cache_way_3[set];

//wire [taglength:0] tag_0 = line_0[1:taglength];
//wire [taglength:0] tag_1 = line_1[1:taglength];
//wire [taglength:0] tag_2 = line_2[1:taglength];
//wire [taglength:0] tag_3 = line_3[1:taglength];

//wire [taglength:0] tag = address[31:setlength + 1];
//wire [num_ways-1:0] validarray = {line_0[0], line_1[0], line_2[0], line_3[0]};

//wire hit; //cache hit 
//wire [num_ways - 1:0] select; //select signal for mux

//wire[31:0] data1,data2;
//reg mem_valid;
//multiplecomp mc_1(tag_0, tag_1, tag_2, tag_3, validarray, tag,valid_l1, hit, select);

//muxnto1 m(line_0[31:0], line_1[31:0], line_2[31:0], line_3[31:0], select, wstrb, data);
//        //go to memory and get data2

reg mem_valid;


mycache mc1(clk, wstrb, address, valid_l1, l1_data, mem_wdata, hit);
always@(clk)
begin
mem_ready <= 0;
    if(hit)
       if (valid_l1 && !mem_ready) begin
       data <= l1_data;
       mem_ready <= 1;
       end
       
    else
       data <= 32'bz; 
       mem_valid <= 1;     
end        
reg [31:0] memory [0:255];  
initial begin
		memory[0] = 32'h 3fc00093; //       li      x1,1020
		memory[1] = 32'h 0000a023; //       sw      x0,0(x1)
		memory[2] = 32'h 0000a103; // loop: lw      x2,0(x1)
		memory[3] = 32'h 00110113; //       addi    x2,x2,1
		memory[4] = 32'h 0020a023; //       sw      x2,0(x1)
		memory[5] = 32'h ff5ff06f; //       j       <loop>
	end

	always @(posedge clk) begin
		mem_ready <= 0;
		if (mem_valid && !mem_ready) begin
			if (address < 1024) begin
				mem_ready <= 1;
				data <= memory[address >> 2];
				if (wstrb[0]) memory[address >> 2][ 7: 0] <= mem_wdata[ 7: 0];
				if (wstrb[1]) memory[address >> 2][15: 8] <= mem_wdata[15: 8];
				if (wstrb[2]) memory[address >> 2][23:16] <= mem_wdata[23:16];
				if (wstrb[3]) memory[address >> 2][31:24] <= mem_wdata[31:24];
			end
			/* add memory-mapped IO here */
			
		end
	end

endmodule