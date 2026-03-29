//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2025 08:51:58 PM
// Design Name: 
// Module Name: PAD
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


module PAD(
    inout  wire        A_PAD,
    inout  wire        B_PAD,
    inout  wire        C_PAD,
    inout  wire        D_PAD,
    inout  wire        E_PAD,
    inout  wire        F_PAD,
    inout  wire        G_PAD,
    inout  wire        H_PAD,
    input  logic [7:0] GPA0_PAD_OUT,
    input  logic [7:0] GPA0_PAD_EN,
    output logic [7:0] GPA0_PAD_IN,
    
    input logic [7:0]  PAD_DS0, 
    input logic [7:0]  PAD_DS1, 
    input logic [7:0]  PAD_DS2, 
    input logic [7:0]  PAD_PE, 
    input logic [7:0]  PAD_PS1, 
    input logic [7:0]  PAD_PS2 
    );

pad_1 u_pad_0(
    .A  (GPA0_PAD_OUT[0]),
    .OE (GPA0_PAD_EN[0]),
    .PE (PAD_PE[0]),
    .PS1(PAD_PS1[0]),
    .PS2(PAD_PS2[0]),
    .DS0(PAD_DS0[0]),
    .DS1(PAD_DS1[0]),
    .DS2(PAD_DS2[0]),
    .PAD(A_PAD),
    .Y  (GPA0_PAD_IN[0])
    );

pad_1 u_pad_1(
    .A  (GPA0_PAD_OUT[1]),
    .OE (GPA0_PAD_EN[1]),
    .PE (PAD_PE[1]),
    .PS1(PAD_PS1[1]),
    .PS2(PAD_PS2[1]),
    .DS0(PAD_DS0[1]),
    .DS1(PAD_DS1[1]),
    .DS2(PAD_DS2[1]),
    .PAD(B_PAD),
    .Y  (GPA0_PAD_IN[1])
    );

pad_1 u_pad_2(
    .A  (GPA0_PAD_OUT[2]),
    .OE (GPA0_PAD_EN[2]),
    .PE (PAD_PE[2]),
    .PS1(PAD_PS1[2]),
    .PS2(PAD_PS2[2]),
    .DS0(PAD_DS0[2]),
    .DS1(PAD_DS1[2]),
    .DS2(PAD_DS2[2]),
    .PAD(C_PAD),
    .Y  (GPA0_PAD_IN[2])
    );

pad_1 u_pad_3(
    .A  (GPA0_PAD_OUT[3]),
    .OE (GPA0_PAD_EN[3]),
    .PE (PAD_PE[3]),
    .PS1(PAD_PS1[3]),
    .PS2(PAD_PS2[3]),
    .DS0(PAD_DS0[3]),
    .DS1(PAD_DS1[3]),
    .DS2(PAD_DS2[3]),
    .PAD(D_PAD),
    .Y  (GPA0_PAD_IN[3])
    );

pad_1 u_pad_4(
    .A  (GPA0_PAD_OUT[4]),
    .OE (GPA0_PAD_EN[4]),
    .PE (PAD_PE[4]),
    .PS1(PAD_PS1[4]),
    .PS2(PAD_PS2[4]),
    .DS0(PAD_DS0[4]),
    .DS1(PAD_DS1[4]),
    .DS2(PAD_DS2[4]),
    .PAD(E_PAD),
    .Y  (GPA0_PAD_IN[4])
    );

pad_1 u_pad_5(
    .A  (GPA0_PAD_OUT[5]),
    .OE (GPA0_PAD_EN[5]),
    .PE (PAD_PE[5]),
    .PS1(PAD_PS1[5]),
    .PS2(PAD_PS2[5]),
    .DS0(PAD_DS0[5]),
    .DS1(PAD_DS1[5]),
    .DS2(PAD_DS2[5]),
    .PAD(F_PAD),
    .Y  (GPA0_PAD_IN[5])
    );

pad_1 u_pad_6(
    .A  (GPA0_PAD_OUT[6]),
    .OE (GPA0_PAD_EN[6]),
    .PE (PAD_PE[6]),
    .PS1(PAD_PS1[6]),
    .PS2(PAD_PS2[6]),
    .DS0(PAD_DS0[6]),
    .DS1(PAD_DS1[6]),
    .DS2(PAD_DS2[6]),
    .PAD(G_PAD),
    .Y  (GPA0_PAD_IN[6])
    );

pad_1 u_pad_7(
    .A  (GPA0_PAD_OUT[7]),
    .OE (GPA0_PAD_EN[7]),
    .PE (PAD_PE[7]),
    .PS1(PAD_PS1[7]),
    .PS2(PAD_PS2[7]),
    .DS0(PAD_DS0[7]),
    .DS1(PAD_DS1[7]),
    .DS2(PAD_DS2[7]),
    .PAD(H_PAD),
    .Y  (GPA0_PAD_IN[7])
    );
endmodule
