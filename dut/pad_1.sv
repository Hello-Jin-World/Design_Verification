//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2025 08:55:18 PM
// Design Name: 
// Module Name: pad_1
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


module pad_1(
    input  logic A,
    input  logic OE,
    input  logic PE,
    input  logic PS1,
    input  logic PS2,
    input  logic DS0,
    input  logic DS1,
    input  logic DS2,
    inout  wire  PAD,
    output logic Y
    );

    reg PAD_in;

    assign PAD = (OE)? A : 1'hz;
    assign Y = PAD_in;
  
    always @(*) begin
        if (!OE) begin
            PAD_in <= PAD;
        end
    end
endmodule
