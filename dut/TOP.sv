`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2025 09:05:33 PM
// Design Name: 
// Module Name: TOP
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


module TOP(
    inout  wire         A_PAD,
    inout  wire         B_PAD,
    inout  wire         C_PAD,
    inout  wire         D_PAD,
    inout  wire         E_PAD,
    inout  wire         F_PAD,
    inout  wire         G_PAD,
    inout  wire         H_PAD,

    input  logic        ACLK,
    input  logic        ARESETn,

    // AW Channel
    input  logic [ 4:0] AWID,
    input  logic [31:0] AWADDR,
    input  logic [ 3:0] AWLEN,
    input  logic [ 2:0] AWSIZE,
    input  logic [ 1:0] AWBURST,
    input  logic        AWVALID,
    output logic        AWREADY,
    // W Channel
    input  logic [31:0] WDATA,
    input  logic [ 3:0] WSTRB,
    input  logic        WLAST,
    input  logic        WVALID,
    output logic        WREADY,
    // B Channel
    output logic [ 4:0] BID,
    output logic [ 2:0] BRESP,
    output logic        BVALID,
    input  logic        BREADY,
    // AR Channel
    input  logic [ 4:0] ARID,
    input  logic [31:0] ARADDR,
    input  logic [ 3:0] ARLEN,
    input  logic [ 2:0] ARSIZE,
    input  logic [ 1:0] ARBURST,
    input  logic        ARVALID,
    output logic        ARREADY,
    // R Channel
    output logic [ 4:0] RID,
    output logic [31:0] RDATA,
    output logic [ 2:0] RRESP, 
    output logic        RLAST,
    output logic        RVALID,
    input  logic        RREADY
    );

    wire        PSEL;
    wire [31:0] PADDR;
    wire [31:0] PWDATA;
    wire [31:0] PRDATA;
    wire        PWRITE;
    wire        PENABLE;
    wire        PREADY;
    wire        PSLVERR;

    wire [7:0] GPA0_PAD_IN;
    wire [7:0] GPA0_PAD_OUT;
    wire [7:0] GPA0_PAD_EN;

    wire [7:0] PAD_DS0; 
    wire [7:0] PAD_DS1; 
    wire [7:0] PAD_DS2; 
    wire [7:0] PAD_PE;
    wire [7:0] PAD_PS1; 
    wire [7:0] PAD_PS2;

AXI2APB AXI2APB_Bridge(
    .ACLK   (ACLK   ),
    .ARESETn(ARESETn),
    //// AXI4 SLAVE
    // AW Channel
    .AWID   (AWID   ),
    .AWADDR (AWADDR ),
    .AWLEN  (AWLEN  ),
    .AWSIZE (AWSIZE ),
    .AWBURST(AWBURST),
    .AWVALID(AWVALID),
    .AWREADY(AWREADY),
    // W Channel
    .WDATA (WDATA ),
    .WSTRB (WSTRB ),
    .WLAST (WLAST ),
    .WVALID(WVALID),
    .WREADY(WREADY),
    // B Channel
    .BID   (BID   ),
    .BRESP (BRESP ),
    .BVALID(BVALID),
    .BREADY(BREADY),
    // AR Channel
    .ARID   (ARID   ),
    .ARADDR (ARADDR ),
    .ARLEN  (ARLEN  ),
    .ARSIZE (ARSIZE ),
    .ARBURST(ARBURST),
    .ARVALID(ARVALID),
    .ARREADY(ARREADY),
    // R Channel
    .RID   (RID   ),
    .RDATA (RDATA ),
    .RRESP (RRESP ), 
    .RLAST (RLAST ),
    .RVALID(RVALID),
    .RREADY(RREADY),

    //// APB MASTER 
    .PSEL   (PSEL   ),
    .PADDR  (PADDR  ),
    .PWDATA (PWDATA ),
    .PRDATA (PRDATA ),
    .PWRITE (PWRITE ),
    .PENABLE(PENABLE),
    .PREADY (PREADY ),
    .PSLVERR(PSLVERR)
);

GPIO u_GPIO(
    .CLK         (1'b0),
    .RESETn      (1'b0),

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
    .GPA0_PAD_IN (GPA0_PAD_IN ),
    .GPA0_PAD_OUT(GPA0_PAD_OUT),
    .GPA0_PAD_EN (GPA0_PAD_EN ),
    .PAD_DS0     (PAD_DS0), 
    .PAD_DS1     (PAD_DS1), 
    .PAD_DS2     (PAD_DS2), 
    .PAD_PE      (PAD_PE ),  
    .PAD_PS1     (PAD_PS1), 
    .PAD_PS2     (PAD_PS2) 
);

PAD u_PAD(
    .A_PAD       (A_PAD),
    .B_PAD       (B_PAD),
    .C_PAD       (C_PAD),
    .D_PAD       (D_PAD),
    .E_PAD       (E_PAD),
    .F_PAD       (F_PAD),
    .G_PAD       (G_PAD),
    .H_PAD       (H_PAD),
    .GPA0_PAD_OUT(GPA0_PAD_OUT),
    .GPA0_PAD_EN (GPA0_PAD_EN ),
    .GPA0_PAD_IN (GPA0_PAD_IN ),
    .PAD_DS0     (PAD_DS0), 
    .PAD_DS1     (PAD_DS1), 
    .PAD_DS2     (PAD_DS2), 
    .PAD_PE      (PAD_PE ), 
    .PAD_PS1     (PAD_PS1), 
    .PAD_PS2     (PAD_PS2) 
    );
endmodule
