`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:40 06/04/2024 
// Design Name: 
// Module Name:    InstructionMemory 
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

module InstructionMemory(
    input [7:0] address,
    output [7:0] instruction
    );

    reg [7:0] memory [255:0];

    initial begin
        // Load instructions into memory here
        // memory[0] = 8'b00000000; // Example instruction
    end

    assign instruction = memory[address];
endmodule
