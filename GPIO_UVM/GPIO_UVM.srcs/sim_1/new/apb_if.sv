`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_if
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

interface apb_if (
    input logic PCLK,
    input logic PRESETn
);
    logic        PSEL;
    logic [31:0] PADDR;
    logic [31:0] PWDATA;
    logic [31:0] PRDATA;
    logic        PWRITE;
    logic        PENABLE;
    logic        PREADY;
    logic        PSLVERR;
endinterface
