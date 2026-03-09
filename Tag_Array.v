`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 05:15:39
// Design Name: 
// Module Name: Tag_Array
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


module Tag_Array(
    input clk, // clk signal 
    input write_enable, // to whether update the tag stored in cache or not
    input [3:0] index,  // which line in cache to access where the data will be stored
    input [23:0] tag_in, // extracted tag from the CPU address
    output reg [23:0] tag_out //sends stored tag back to cache controller
    );
    
reg [23:0] tag_mem [15:0]; // [24:0] is for the storing the bits of the tag, [15:0] is for the number of cache lines available

always @(posedge clk) begin
    if(write_enable)
        tag_mem[index] <= tag_in; // if write enable is 1, the extracted tag will be stored in the cache i.e when there is a cache miss

    tag_out <= tag_mem[index]; // shows the tag stored at that index as the output
    end
endmodule
