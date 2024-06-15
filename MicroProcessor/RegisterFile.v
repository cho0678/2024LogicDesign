`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:52 06/04/2024 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(
    input [1:0] rs, rt, rd,
    input [7:0] writeData,
    input RegWrite,
    input clk,
    output [7:0] rsData, rtData
    );

    reg [7:0] registers [3:0];

    always @(posedge clk) begin
        if (RegWrite) begin
            registers[rd] <= writeData;
        end
    end

    assign rsData = registers[rs];
    assign rtData = registers[rt];
endmodule
