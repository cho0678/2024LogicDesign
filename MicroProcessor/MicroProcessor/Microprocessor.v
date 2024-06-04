`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:37 06/04/2024 
// Design Name: 
// Module Name:    Microprocessor 
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
module Microprocessor(
    input clk,
    input reset,
	 input [7:0] instruction,
    output [6:0] seg,
	 output [7:0] Read_Address
    );

    wire [7:0] PC;
    wire [7:0] nextPC;
    wire [1:0] rs, rt, rd;
    wire [7:0] rsData, rtData, writeData, ALUResult;
    wire [1:0] ALUControl;
    wire RegWrite, MemRead, MemWrite, Branch;
	 
	 assign Read_Address = PC;

    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .PC(PC)
    );


    assign rs = instruction[5:4];
    assign rt = instruction[3:2];
    assign rd = instruction[1:0];

    RegisterFile rf(
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writeData(writeData),
        .RegWrite(RegWrite),
        .clk(clk),
        .rsData(rsData),
        .rtData(rtData)
    );

    ALU alu(
        .A(rsData),
        .B(rtData),
        .Y(ALUResult)
    );

    ControlUnit cu(
        .op(instruction[7:6]),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch)
    );

    DataMemory dm(
        .clk(clk),
        .address(ALUResult),
        .writeData(rsData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .readData(writeData)
    );

    assign nextPC = Branch ? PC + {{6{instruction[5]}}, instruction[5:0]} : PC + 1;
	 
	 //need modification. need another 7seg display 
    Hex_to_7seg display(
        .hex(writeData[3:0]),
        .seg(seg)
    );

endmodule
