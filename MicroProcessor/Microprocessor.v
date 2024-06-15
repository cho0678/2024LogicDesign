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
    output [6:0] seg3,
    output [6:0] seg4,
    output [7:0] PC,
	 output clocksignal
);

    wire clk;
    wire [7:0] nextPC;
    wire [1:0] rs, rt, rd, RegisterDestination, operation;
    wire [7:0] rsData, rtData, writeData, ALUResult, MemoryResult, MemoryAddress;
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
    assign operation = instruction[7:6];
	 

    // Control Unit
    ControlUnit cu(
        .op(instruction[7:6]),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch)
    );

	 // Register writeData value assign
	 assign writeData = (operation==2'b00) ? ALUResult 
	 			: (operation == 2'b11) ? {6'b000000, rd}
	 			: MemoryResult;
	 
	 assign RegisterDestination = ALUControl ? rd : rt;
	 
	
    // Register File
    RegisterFile rf(
        .rs(rs),
        .rt(rt),
        .rd(RegisterDestination),
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
	 
    // Memory Address Logic
	 assign MemoryAddress = (rd == 2'b00) ? rsData :
									(rd ==2'b01) ? rsData + 8'b00000001:
									(rd ==2'b10) ? rsData - 8'b00000010:
									(rd ==2'b11) ? rsData - 8'b00000001 :
									rsData;

    // Data Memory
    DataMemory dm(
        .clk(clk),
        .address(MemoryAddress),
        .writeData(rtData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .readData(MemoryResult)
    );

    // PC Update logic
	 assign nextPC = (rd == 2'b00) ? PC + 1 :
                    (rd == 2'b01) ? (Branch ? PC + 2 : PC + 1) :
                    (rd == 2'b10) ? (Branch ? PC - 1 : PC + 1) :
                    (rd == 2'b11) ? (Branch ? PC : PC + 1) :
                    PC + 1;
	

    // 7-segment display for writeData
    Hex_to_7seg display1(
        .hex(writeData[7:4]),
        .seg(seg1)
    );
    
    Hex_to_7seg display2(
        .hex(writeData[3:0]),
        .seg(seg2)
    );
	 //7seg pc
	 Hex_to_7seg display3(
        .hex(PC[7:4]),
        .seg(seg3)
    );
    
    Hex_to_7seg display4(
        .hex(PC[3:0]),
        .seg(seg4)
    );
	 
	 //clocksignal
	assign clocksignal = clk;
endmodule
