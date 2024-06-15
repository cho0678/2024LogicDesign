`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:04 06/04/2024 
// Design Name: 
// Module Name:    DataMemory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DataMemory(
    input clk,
    input [7:0] address,
    input [7:0] writeData,
    input MemWrite,
    input MemRead,
    output [7:0] readData
    );

    reg [7:0] memory [31:0];
	 
	 integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            memory[i] = i;
        end
        for (i = 16; i < 32; i = i + 1) begin
            memory[i] = - (i - 16);
        end
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address] <= writeData;
        end
    end

    assign readData = (MemRead) ? memory[address] : writeData;
endmodule
