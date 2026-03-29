`timescale 1ns/1ns

// Interface
interface axi_if(input logic ACLK, input logic ARESETn);
    // AW Channel
    logic [ 4:0] AWID;
    logic [31:0] AWADDR;
    logic [ 3:0] AWLEN;
    logic [ 2:0] AWSIZE;
    logic [ 1:0] AWBURST;
    logic        AWVALID;
    logic        AWREADY;
    // W Channel
    logic [31:0] WDATA;
    logic [ 3:0] WSTRB;
    logic        WLAST;
    logic        WVALID;
    logic        WREADY;
    // B Channel
    logic [ 4:0] BID;
    logic [ 2:0] BRESP;
    logic        BVALID;
    logic        BREADY;
    // AR Channel
    logic [ 4:0] ARID;
    logic [31:0] ARADDR;
    logic [ 3:0] ARLEN;
    logic [ 2:0] ARSIZE;
    logic [ 1:0] ARBURST;
    logic        ARVALID;
    logic        ARREADY;
    // R Channel
    logic [ 4:0] RID;
    logic [31:0] RDATA;
    logic [ 2:0] RRESP; 
    logic        RLAST;
    logic        RVALID;
    logic        RREADY;
    

    clocking drv_cb @(posedge ACLK);
        default input #1ns output #1ns;
        output  AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID,
                WDATA, WSTRB, WLAST, WVALID,
                BREADY, 
                ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID,
                RREADY;
        input   AWREADY,
                WREADY,
                BID, BRESP, BVALID,
                ARREADY,
                RID, RDATA, RRESP, RLAST, RVALID;
    endclocking

    clocking mon_cb @(posedge ACLK);
        default input #1ns output #1ns;
        input  AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID,
                WDATA, WSTRB, WLAST, WVALID,
                BREADY, 
                ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID,
                RREADY;
        input   AWREADY,
                WREADY,
                BID, BRESP, BVALID,
                ARREADY,
                RID, RDATA, RRESP, RLAST, RVALID;
    endclocking
endinterface
