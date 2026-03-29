`timescale 1ns/1ns

// Interface
interface apb_if(input logic PCLK, input logic PRESETn);
    logic [31:0] PADDR, PWDATA, PRDATA;
    logic        PSEL, PENABLE, PWRITE, PREADY, PSLVERR;

    clocking drv_cb @(posedge PCLK);
        default input #1ns output #1ns;
        output PADDR, PWDATA, PSEL, PENABLE, PWRITE;
        input  PRDATA, PREADY, PSLVERR;
    endclocking

    clocking mon_cb @(posedge PCLK);
        default input #1ns output #1ns;
        input  PADDR, PWDATA, PSEL, PENABLE, PWRITE;
        input  PRDATA, PREADY, PSLVERR;
    endclocking
endinterface
