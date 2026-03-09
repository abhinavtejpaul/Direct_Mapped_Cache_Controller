`timescale 1ns / 1ps

module Main_Memory(
    input clk, //clk signal 
    input read, // tells the memory to return the data
    input [31:0] address, // this is the requested memory address by the CPU
    output reg [31:0] data_out // sends the stored data at the requested address
);

reg [31:0] memory [255:0]; // [31:0] indicates that each memory location stores 32 bits; [255:0] indicates the number of memory locations
integer i; 
initial 
begin
    for(i=0;i<256;i=i+1) // this loop fills all the memory locations
        memory[i] = i * 10; // to easily verify the simulation since this loop is storing data that is defined bu i*10
end

always @(posedge clk) begin
    if(read)
        data_out <= memory[address[7:0]]; // if read = 1, we access the memory location and send the stored value to data_out
end
endmodule
