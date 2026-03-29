//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2025 04:21:40 PM
// Design Name: 
// Module Name: GPIO_SFR_DEC
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


module GPIO_SFR_DEC(
    input  logic [31:0] PADDR,
    output logic       DECERR,
    output logic       SEL_CON,
    output logic       SEL_DAT,
    output logic       SEL_PUD,
    output logic       SEL_DRV
    );

    assign SEL_CON = (PADDR[15:0] == 16'h0000) ? 1'b1 : 1'b0;
    assign SEL_DAT = (PADDR[15:0] == 16'h0004) ? 1'b1 : 1'b0;
    assign SEL_PUD = (PADDR[15:0] == 16'h0008) ? 1'b1 : 1'b0;
    assign SEL_DRV = (PADDR[15:0] == 16'h000c) ? 1'b1 : 1'b0;
    // Address decoding error
    assign DECERR = (PADDR[15:0] == 16'h0000) ? 1'b0 : 
                    (PADDR[15:0] == 16'h0004) ? 1'b0 : 
                    (PADDR[15:0] == 16'h0008) ? 1'b0 : 
                    (PADDR[15:0] == 16'h000c) ? 1'b0 : 1'b1;
    
endmodule
