//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2025 04:10:34 PM
// Design Name: 
// Module Name: GPIO_SFR
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


module GPIO_SFR(
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

    // GPIO SFR
    output logic [31:0] GPIO_CON, 
    output logic [31:0] GPIO_DAT, 
    output logic [31:0] GPIO_PUD, 
    output logic [31:0] GPIO_DRV, 

    // PAD
    input  logic [7:0]  GPA0_PAD_IN,
    output logic [7:0]  GPA0_PAD_OUT
    );

    wire SEL_CON;
    wire SEL_DAT;
    wire SEL_PUD;
    wire SEL_DRV;

    reg [31:0] PRDATA_reg;
    assign PREADY = 1;
    assign PSLVERR = DECERR;

    always_ff @(posedge PCLK, negedge PRESETn) begin
        if (!PRESETn) begin
            PRDATA <= 0;
        end else begin
            if (PCLK & !PWRITE) begin
                PRDATA <= PRDATA_reg;
            end
        end
    end

GPIO_SFR_DEC uGPIO_SFR_DEC(
    .PADDR  (PADDR  ),
    .DECERR (DECERR ),
    .SEL_CON(SEL_CON),
    .SEL_DAT(SEL_DAT),
    .SEL_PUD(SEL_PUD),
    .SEL_DRV(SEL_DRV)
    );

SFR uGPIO_SFR_CON(
    .CLK    (PCLK),
    .RESETn (PRESETn),
    .REG_SEL(SEL_CON),
    .WR_EN  (PSEL & PENABLE & PWRITE),
    .WDATA  (PWDATA),
    .RDATA  (GPIO_CON)
    );

SFR uGPIO_SFR_DAT(
    .CLK    (PCLK),
    .RESETn (PRESETn),
    .REG_SEL(SEL_DAT),
    .WR_EN  (PSEL & PENABLE & PWRITE),
    .WDATA  (PWDATA),
    .RDATA  (GPIO_DAT)
    );

SFR uGPIO_SFR_PUD(
    .CLK    (PCLK),
    .RESETn (PRESETn),
    .REG_SEL(SEL_PUD),
    .WR_EN  (PSEL & PENABLE & PWRITE),
    .WDATA  (PWDATA),
    .RDATA  (GPIO_PUD)
    );

SFR uGPIO_SFR_DRV(
    .CLK    (PCLK),
    .RESETn (PRESETn),
    .REG_SEL(SEL_DRV),
    .WR_EN  (PSEL & PENABLE & PWRITE),
    .WDATA  (PWDATA),
    .RDATA  (GPIO_DRV)
    );

    assign GPA0_PAD_OUT = GPIO_DAT[7:0];

    always_comb begin
        case(1'b1)
            SEL_CON : PRDATA_reg = GPIO_CON;
            SEL_DAT : PRDATA_reg = GPIO_DAT;
            SEL_PUD : PRDATA_reg = GPIO_PUD;
            SEL_DRV : PRDATA_reg = GPIO_DRV;
            default : PRDATA_reg = 32'b0;
        endcase
    end
endmodule
