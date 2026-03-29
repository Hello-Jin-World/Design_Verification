`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

    // Clock & reset
    logic PCLK = 0;
    logic PRESETn;

    // APB interface instance
    apb_if apb_if_inst(PCLK, PRESETn);

    // DUT instantiation
    TOP dut (
        .A_PAD(), .B_PAD(), .C_PAD(), .D_PAD(),
        .E_PAD(), .F_PAD(), .G_PAD(), .H_PAD(),  // pad는 오늘은 무시하므로 연결 안 함

        .PCLK   (PCLK),
        .PRESETn(PRESETn),
        .PSEL   (apb_if_inst.PSEL),
        .PADDR  (apb_if_inst.PADDR),
        .PWDATA (apb_if_inst.PWDATA),
        .PRDATA (apb_if_inst.PRDATA),
        .PWRITE (apb_if_inst.PWRITE),
        .PENABLE(apb_if_inst.PENABLE),
        .PREADY (apb_if_inst.PREADY),
        .PSLVERR(apb_if_inst.PSLVERR)
    );

    // Clock generation
    always #5 PCLK = ~PCLK;

    // Reset generation
    initial begin
        PRESETn = 0;
        #50;
        PRESETn = 1;
    end

    // Run UVM
    initial begin
        uvm_config_db#(virtual apb_if)::set(null, "*", "vif", apb_if_inst);
        run_test("my_test");
    end

endmodule
