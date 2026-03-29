//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 10:11:51 PM
// Design Name: 
// Module Name: GPIO
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

module GPIO(
    input logic         CLK,
    input logic         RESETn,

    // APB INTERFACE
    input  logic        PCLK,
    input  logic        PRESETn,
    input  logic        PSEL,
    input  logic [31:0] PADDR,
    input  logic [31:0] PWDATA,
    output logic [31:0] PRDATA,
    input  logic        PWRITE,
    input  logic        PENABLE,
    output logic        PREADY,
    output logic        PSLVERR,

    // PAD
    input  logic [7:0]  GPA0_PAD_IN,
    output logic [7:0]  GPA0_PAD_OUT,
    output logic [7:0]  GPA0_PAD_EN,
    
    output logic [7:0]  PAD_DS0, 
    output logic [7:0]  PAD_DS1, 
    output logic [7:0]  PAD_DS2, 
    output logic [7:0]  PAD_PE, 
    output logic [7:0]  PAD_PS1, 
    output logic [7:0]  PAD_PS2 
);


    wire [31:0] GPIO_CON; 
    wire [31:0] GPIO_DAT; 
    wire [31:0] GPIO_PUD; 
    wire [31:0] GPIO_DRV; 

GPIO_SFR uGPIO_SFR(
    .PCLK        (PCLK        ),
    .PRESETn     (PRESETn     ),
    .PSEL        (PSEL        ),
    .PADDR       (PADDR       ),
    .PWDATA      (PWDATA      ),
    .PRDATA      (PRDATA      ),
    .PWRITE      (PWRITE      ),
    .PENABLE     (PENABLE     ),
    .PREADY      (PREADY      ),
    .PSLVERR     (PSLVERR     ),
    .GPIO_CON    (GPIO_CON    ), 
    .GPIO_DAT    (GPIO_DAT    ), 
    .GPIO_PUD    (GPIO_PUD    ), 
    .GPIO_DRV    (GPIO_DRV    ), 
    .GPA0_PAD_IN (GPA0_PAD_IN ),
    .GPA0_PAD_OUT(GPA0_PAD_OUT)
    );

GPIO_DEC_PAD_INPUT u_GPIO_DEC_PAD_INPUT(
    .GPIO_PUD(GPIO_PUD), 
    .GPIO_DRV(GPIO_DRV), 
    .PAD_DS0 (PAD_DS0 ), 
    .PAD_DS1 (PAD_DS1 ), 
    .PAD_DS2 (PAD_DS2 ), 
    .PAD_PE  (PAD_PE  ),  
    .PAD_PS1 (PAD_PS1 ), 
    .PAD_PS2 (PAD_PS2 ) 
    );

    always_comb begin
        case (GPIO_CON[3:0])
            4'b0000 : GPA0_PAD_EN[0]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[0]= 1; // output mode
            default : GPA0_PAD_EN[0]= 0; // default input 
        endcase

        case (GPIO_CON[7:4])
            4'b0000 : GPA0_PAD_EN[1]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[1]= 1; // output mode
            default : GPA0_PAD_EN[1]= 0; // default input 
        endcase

        case (GPIO_CON[11:8])
            4'b0000 : GPA0_PAD_EN[2]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[2]= 1; // output mode
            default : GPA0_PAD_EN[2]= 0; // default input 
        endcase

        case (GPIO_CON[15:12])
            4'b0000 : GPA0_PAD_EN[3]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[3]= 1; // output mode
            default : GPA0_PAD_EN[3]= 0; // default input 
        endcase

        case (GPIO_CON[19:16])
            4'b0000 : GPA0_PAD_EN[4]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[4]= 1; // output mode
            default : GPA0_PAD_EN[4]= 0; // default input 
        endcase

        case (GPIO_CON[23:20])
            4'b0000 : GPA0_PAD_EN[5]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[5]= 1; // output mode
            default : GPA0_PAD_EN[5]= 0; // default input 
        endcase

        case (GPIO_CON[27:24])
            4'b0000 : GPA0_PAD_EN[6]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[6]= 1; // output mode
            default : GPA0_PAD_EN[6]= 0; // default input 
        endcase

        case (GPIO_CON[31:28])
            4'b0000 : GPA0_PAD_EN[7]= 0; // input mode
            4'b0001 : GPA0_PAD_EN[7]= 1; // output mode
            default : GPA0_PAD_EN[7]= 0; // default input 
        endcase
    end

endmodule

