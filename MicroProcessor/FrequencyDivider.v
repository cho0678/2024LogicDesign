`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:40 06/04/2024 
// Design Name: 
// Module Name:    FrequencyDivider 
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
module FrequencyDivider(
    input clr,
    input clk,
    output reg clkout
    );
    reg [31:0] cnt;
	 
	 initial begin
		clkout <= 1'b0;
	 end
	 
    always@(posedge clk) 
    begin
        if (clr) 
        begin
            cnt <=32'd0;
            clkout <= 1'b0;
        end
        else if (cnt==32'd25000000)
        begin
            cnt <=32'd0;
            clkout <= ~clkout;
        end 
        else
        begin 
            cnt <= cnt+1;
        end 
    end 
endmodule
