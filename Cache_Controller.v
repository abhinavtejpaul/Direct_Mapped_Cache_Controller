`timescale 1ns / 1ps

module Cache_Controller(
    input clk, //clk signal
    input reset, // to initialize the system
    input read, // to check whehter the CPU wants to read data from the memory
    input [31:0] address, // the 32-bit memory address from the CPU
    output reg hit, // tells the CPU whether there is a cache hit or cache miss
    output reg [31:0] data_out // sends the requested data back to the CPU
);

wire [3:0] index; // both of these store parts of the address
wire [23:0] tag;

assign index = address[7:4]; // to determine which cache line to access; [7:4] is to tell where to look for the index in the 32-bit address
assign tag = address[31:8]; // to determine the tag which identifies the memory block stored in the cache line; [31:8] is to tell where to look for the tag in the 32-bit address

wire [31:0] cache_data; // to store the data read from cache 
wire [23:0] cache_tag; // to store the tag stored in cache
wire valid_bit; // to check the valid status of the cache line

reg write_enable; // to check whether the cache arrays should be updated or not

wire [31:0] mem_data; // to carry data from the main memory

// we will be instantiating all the previous modules in this module 

Data_Array data_mem(
    .clk(clk),
    .write_enable(write_enable),
    .index(index),
    .data_in(mem_data),
    .data_out(cache_data)
);             

Tag_Array tag_mem(
    .clk(clk),
    .write_enable(write_enable),
    .index(index),
    .tag_in(tag),
    .tag_out(cache_tag)
);

Valid_Array valid_mem(
    .clk(clk),
    .write_enable(write_enable),
    .index(index),
    .valid_in(1'b1),
    .valid_out(valid_bit)
);

Main_Memory mem(
    .clk(clk),
    .read(read),
    .address(address),
    .data_out(mem_data)
);

always @(posedge clk or posedge reset) 
begin
    if(reset) begin  // to ensure a safe startup for the cache controller
        hit <= 0;
        data_out <= 0;
        write_enable <= 0;
    end
    else begin
        if(valid_bit && (cache_tag == tag)) begin // if the valid bit = 1 and the tag matches, we get a cache hit
            hit <= 1; // informs the CPU regarding the cache hit
            data_out <= cache_data; // sends the cached data as data output
            write_enable <= 0; // to tell the CPU not to update the cache
        end
        else begin // if the valid bit = 0 or the tag mismatches, we get a cache miss
            hit <= 0; // informs the CPU regarding the cache miss
            write_enable <= 1; // tells the CPU to update the cache 
            data_out <= mem_data; // the date is fetched from the memory, stored in the cache and send to the CPU
        end
    end
end
endmodule
