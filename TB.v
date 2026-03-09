`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 05:38:41
// Design Name: 
// Module Name: TB
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


module TB(  );

reg clk;
reg reset;
reg read;
reg [31:0] address;
wire hit;
wire [31:0] data_out;

Cache_Controller uut(
    .clk(clk),
    .reset(reset),
    .read(read),
    .address(address),
    .hit(hit),
    .data_out(data_out)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    read = 0;
    address = 0;
    #10
    reset = 0;
    read = 1;
    #20 address = 32'h00000010;
    #20 address = 32'h00000010;
    #20 address = 32'h00000020;
    #20 address = 32'h00000010;
    #20 address = 32'h00000030;
    #20 address = 32'h00000030;
    #50 $finish;

end
initial begin
    $monitor("Time=%0t Address=%h Hit=%b Data=%h",
             $time,address,hit,data_out);
end
endmodule
