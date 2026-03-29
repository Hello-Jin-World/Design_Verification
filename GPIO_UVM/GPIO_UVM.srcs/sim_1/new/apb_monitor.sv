`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_monitor
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

class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual apb_if vif;
    uvm_analysis_port#(apb_seq_item) ap;

    function new(string name="apb_monitor", uvm_component parent=null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "APB vif not found")
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_seq_item item;

        forever begin
            @(posedge vif.PCLK);
            if (vif.PSEL && vif.PENABLE) begin
                item = apb_seq_item::type_id::create("item");
                item.addr  = vif.PADDR;
                item.write = vif.PWRITE;
                item.data  = vif.PWRITE ? vif.PWDATA : vif.PRDATA;
                ap.write(item);
            end
        end
    endtask

endclass
 
