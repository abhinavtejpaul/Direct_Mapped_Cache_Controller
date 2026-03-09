`timescale 1ns / 1ps

module Valid_Array(
    input clk, // clk signal
    input write_enable, // to whether update the valid bit or not
    input [3:0] index, // which line in cache to access where the data will be stored
    input valid_in, // to store the new valid bit after a cache miss
    output reg valid_out // to send the stored valid bit in cache to the cache controller
);

reg valid_mem [15:0]; // [15:0] indicates the number of lines in the cache available for storing data

always @(posedge clk) begin
    if(write_enable)
        valid_mem[index] <= valid_in; // if there is a cache miss, the valid bit gets updated at the given index

    valid_out <= valid_mem[index]; // gives the valid bit from the selected cache line as output
    end
endmodule
