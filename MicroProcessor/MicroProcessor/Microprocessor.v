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
    input oscillator,
    input reset,
    input [7:0] instruction,
    output [6:0] seg1,
    output [6:0] seg2,
    output [7:0] PC
);

    wire clk;
    wire [7:0] nextPC;
    wire [1:0] rs, rt, rd;
    wire [7:0] rsData, rtData, writeData, ALUResult;
    wire [1:0] ALUControl;
    wire RegWrite, MemRead, MemWrite, Branch;

    // Frequency Divider
    FrequencyDivider clock(
        .clkout(clk),
        .clr(reset),
        .clk(oscillator)
    );

    // Program Counter
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .PC(PC)
    );

    // Instruction fields
    assign rs = instruction[5:4];
    assign rt = instruction[3:2];
    assign rd = instruction[1:0];

    // Register File
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

    // ALU
    ALU alu(
        .A(rsData),
        .B(rtData),
        .Y(ALUResult)
    );

    // Control Unit
    ControlUnit cu(
        .op(instruction[7:6]),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch)
    );

    // Data Memory
    DataMemory dm(
        .clk(clk),
        .address(ALUResult),
        .writeData(rtData),  //  rtData? rsData? 
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .readData(writeData)
    );

    // PC Update logic
    assign nextPC = Branch ? PC + {{6{instruction[5]}}, instruction[5:0]} : PC + 1;

    // 7-segment display for writeData
    Hex_to_7seg display1(
        .hex(writeData[7:4]),
        .seg(seg1)
    );
    
    Hex_to_7seg display2(
        .hex(writeData[3:0]),
        .seg(seg2)
    );

endmodule
