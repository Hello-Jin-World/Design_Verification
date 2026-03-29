//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2025 06:19:50 PM
// Design Name: 
// Module Name: SFR
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


module SFR(
    input  logic        CLK,
    input  logic        RESETn,
    input  logic        REG_SEL,
    input  logic        WR_EN,
    input  logic [31:0] WDATA,
    output logic [31:0] RDATA
    );

    reg [31:0] RDATA_reg;

    assign RDATA = RDATA_reg;

    always_ff @(posedge CLK, negedge RESETn) begin
        if (!RESETn) begin
            RDATA_reg <= 0;
        end else begin
            if (WR_EN & REG_SEL) begin
                RDATA_reg <= WDATA;
            end
        end
    end
endmodule
