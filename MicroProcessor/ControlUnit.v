`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:22 06/04/2024 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
    input [1:0] op,
    output reg ALUControl,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch
    );

    always @(op) begin
        case (op)
            2'b00: begin // ADD
                ALUControl <= 1;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 0;
            end
            2'b01: begin // LOAD
                ALUControl <= 0;
                RegWrite <= 1;
                MemRead <= 1;
                MemWrite <= 0;
                Branch <= 0;
            end
            2'b10: begin // STORE
                ALUControl <= 0;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 1;
                Branch <= 0;
            end
            2'b11: begin // JUMP
                ALUControl <= 0;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                Branch <= 1;
            end
        endcase
    end
endmodule
