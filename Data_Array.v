`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 04:52:49
// Design Name: 
// Module Name: Data_Array
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


module Data_Array(
    input clk, // clk signal 
    input write_enable, // to store the data in cache
    input [3:0] index, // which line in cache to access where the data will be stored
    input [31:0] data_in, // data coming into the cache from the main memory after a cache miss
    output reg [31:0] data_out // data sent back to the CPU 
    );
    
reg [31:0] cache_data [15:0]; // [31:0] is for storing each entry that is 32 bits long, [15:0] is for indicating the number of cache lines available for storing the addresses
always @(posedge clk)
begin
    if (write_enable)
        cache_data[index] <= data_in; // if write_enable is 1, store the data
    
    data_out <= cache_data[index]; // to give the stored data as the output when you have a cache hit
end
endmodule
