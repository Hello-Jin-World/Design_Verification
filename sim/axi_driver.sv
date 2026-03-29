`timescale 1ns/1ns

class axi_driver extends uvm_driver #(axi_seq_item);
    `uvm_component_utils(axi_driver)

    virtual axi_if vif;

    function new(string name = "axi_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
            `uvm_fatal("AXI_DRV", "No virtual interface specified for AXI driver")
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info("AXI_DRV", "run_phase entered", UVM_LOW);
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("AXI_DRV", $sformatf("Driving transaction: is_read=%0d, addr=%h, wdata=%h", req.is_read, req.is_read ? req.araddr : req.awaddr, req.wdata), UVM_MEDIUM);
            if (req.is_read) begin
                drive_read(req);
            end else begin
                drive_write(req);
            end
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_write(axi_seq_item item);
        // Set default values
        vif.drv_cb.AWVALID <= 1'b0;
        vif.drv_cb.WVALID  <= 1'b0;
        vif.drv_cb.BREADY  <= 1'b0;

        @(posedge vif.ACLK);
        // Drive AW channel
        vif.drv_cb.AWVALID <= 1'b1;
        vif.drv_cb.AWADDR  <= item.awaddr;
        // For simplicity, using AXI-Lite style properties
        vif.drv_cb.AWLEN   <= 4'b0;
        vif.drv_cb.AWSIZE  <= 3'b010; // 4 bytes
        vif.drv_cb.AWBURST <= 2'b01;  // INCR

      //wait (vif.drv_cb.AWREADY);
        @(posedge vif.ACLK);
      //vif.drv_cb.AWVALID <= 1'b0;

        // Drive W channel
        vif.drv_cb.WVALID <= 1'b1;
        vif.drv_cb.WDATA  <= item.wdata;
        vif.drv_cb.WSTRB  <= 4'hF;
        vif.drv_cb.WLAST  <= 1'b1;
        
      //wait (vif.drv_cb.WREADY);
        @(posedge vif.ACLK);
      //vif.drv_cb.WVALID <= 1'b0;

        wait (vif.drv_cb.AWREADY);
        wait (vif.drv_cb.WREADY);
        vif.drv_cb.AWVALID <= 1'b0;
        vif.drv_cb.WVALID <= 1'b0;
        
        // Wait for B channel response
        vif.drv_cb.BREADY <= 1'b1;
        wait (vif.drv_cb.BVALID);
        @(posedge vif.ACLK);
        // `uvm_info("AXI_DRV", $sformatf("Write response: BRESP=%h", vif.mon_cb.BRESP), UVM_MEDIUM)
        vif.drv_cb.BREADY <= 1'b0;
    endtask

    virtual task drive_read(axi_seq_item item);
        // Set default values
        vif.drv_cb.ARVALID <= 1'b0;
        vif.drv_cb.RREADY  <= 1'b0;

        @(posedge vif.ACLK);
        // Drive AR channel
        vif.drv_cb.ARVALID <= 1'b1;
        vif.drv_cb.ARADDR  <= item.araddr;
        vif.drv_cb.ARLEN   <= 4'b0;
        vif.drv_cb.ARSIZE  <= 3'b010; // 4 bytes
        vif.drv_cb.ARBURST <= 2'b01;  // INCR

        wait (vif.drv_cb.ARREADY);
        @(posedge vif.ACLK);
        vif.drv_cb.ARVALID <= 1'b0;

        // Wait for R channel data
        vif.drv_cb.RREADY <= 1'b1;
        wait (vif.drv_cb.RVALID);
        item.rdata = vif.drv_cb.RDATA;
        @(posedge vif.ACLK);
        // `uvm_info("AXI_DRV", $sformatf("Read data: RDATA=%h", item.rdata), UVM_MEDIUM)
        vif.drv_cb.RREADY <= 1'b0;
    endtask

endclass
