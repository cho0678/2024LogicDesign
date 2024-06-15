`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:20 06/04/2024 
// Design Name: 
// Module Name:    ProgramCounter 
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
module ProgramCounter(
    input clk,
    input reset,
    input [7:0] nextPC,
    output reg [7:0] PC
    );
	 
	 initial begin
		PC <= 8'b0;
	 end

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 8'b0;
        else
            PC <= nextPC;
    end
endmodule
