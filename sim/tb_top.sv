`timescale 1ns/1ns

module tb_top;
    import uvm_pkg::*;
    import gpio_pkg::*;
    `include "uvm_macros.svh"

    logic ACLK;
    logic ARESETn;

    initial begin
        ACLK = 0;
        forever #5 ACLK = ~ACLK;
    end

    initial begin
        ARESETn = 0;
        #20;
        ARESETn = 1;
    end

  //apb_if apb_if_inst(
  //    .PCLK    (PCLK),
  //    .PRESETn (PRESETn)
  //);
    axi_if axi_if_inst(
        .ACLK   (ACLK),
        .ARESETn(ARESETn)
    );

    TOP u_dut (
        .ACLK   (ACLK   ),
        .ARESETn(ARESETn),
        
        .AWID   (axi_if_inst.AWID   ),
        .AWADDR (axi_if_inst.AWADDR ),
        .AWLEN  (axi_if_inst.AWLEN  ),
        .AWSIZE (axi_if_inst.AWSIZE ),
        .AWBURST(axi_if_inst.AWBURST),
        .AWVALID(axi_if_inst.AWVALID),
        .AWREADY(axi_if_inst.AWREADY),
        .WDATA  (axi_if_inst.WDATA  ),
        .WSTRB  (axi_if_inst.WSTRB  ),
        .WLAST  (axi_if_inst.WLAST  ),
        .WVALID (axi_if_inst.WVALID ),
        .WREADY (axi_if_inst.WREADY ),
        .BID    (axi_if_inst.BID    ),
        .BRESP  (axi_if_inst.BRESP  ),
        .BVALID (axi_if_inst.BVALID ),
        .BREADY (axi_if_inst.BREADY ),
        .ARID   (axi_if_inst.ARID   ),
        .ARADDR (axi_if_inst.ARADDR ),
        .ARLEN  (axi_if_inst.ARLEN  ),
        .ARSIZE (axi_if_inst.ARSIZE ),
        .ARBURST(axi_if_inst.ARBURST),
        .ARVALID(axi_if_inst.ARVALID),
        .ARREADY(axi_if_inst.ARREADY),
        .RID    (axi_if_inst.RID    ),
        .RDATA  (axi_if_inst.RDATA  ),
        .RRESP  (axi_if_inst.RRESP  ), 
        .RLAST  (axi_if_inst.RLAST  ),
        .RVALID (axi_if_inst.RVALID ),
        .RREADY (axi_if_inst.RREADY )
  //    .PCLK    (PCLK),
  //    .PRESETn (PRESETn),

  //    .PSEL    (apb_if_inst.PSEL),
  //    .PENABLE (apb_if_inst.PENABLE),
  //    .PADDR   (apb_if_inst.PADDR),
  //    .PWRITE  (apb_if_inst.PWRITE),
  //    .PWDATA  (apb_if_inst.PWDATA),
  //    .PRDATA  (apb_if_inst.PRDATA),
  //    .PREADY  (apb_if_inst.PREADY)
    ); 

    initial begin
        uvm_config_db#(virtual axi_if)::set(null, "*", "vif", axi_if_inst);
        run_test("axi_one_tx_test");
    end
endmodule
