//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2025 06:44:39 PM
// Design Name: 
// Module Name: GPIO_DEC_PAD_INPUT
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


module GPIO_DEC_PAD_INPUT(
    input  logic [31:0] GPIO_PUD, 
    input  logic [31:0] GPIO_DRV, 
    output logic [7:0]  PAD_DS0, 
    output logic [7:0]  PAD_DS1, 
    output logic [7:0]  PAD_DS2, 
    output logic [7:0]  PAD_PE, 
    output logic [7:0]  PAD_PS1, 
    output logic [7:0]  PAD_PS2 
    );

    genvar i;

    generate
       for(i=0; i<8; i=i+1) begin
           assign PAD_PS2[i] = GPIO_PUD[4*i+2]; 
           assign PAD_PS1[i] = GPIO_PUD[4*i+1]; 
           assign PAD_PE[i]  = GPIO_PUD[4*i];

           assign PAD_DS2[i] = GPIO_DRV[4*i+2]; 
           assign PAD_DS1[i] = GPIO_DRV[4*i+1]; 
           assign PAD_DS0[i] = GPIO_DRV[4*i]; 
       end
    endgenerate
endmodule
