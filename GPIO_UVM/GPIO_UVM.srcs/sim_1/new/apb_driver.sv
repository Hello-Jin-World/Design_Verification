`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_driver
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

class apb_driver extends uvm_driver#(apb_seq_item);
    
    `uvm_component_utils(apb_driver)

    virtual apb_if vif;

    function new(string name="apb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "APB interface not found")
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_seq_item item;

        forever begin
            seq_item_port.get_next_item(item);

            // APB protocol
            vif.PSEL    <= 1;
            vif.PWRITE  <= item.write;
            vif.PADDR   <= item.addr;
            vif.PWDATA  <= item.data;
            vif.PENABLE <= 1;

            @(posedge vif.PCLK);
            wait(vif.PREADY === 1);

            // Idle state
            vif.PSEL    <= 0;
            vif.PENABLE <= 0;

            seq_item_port.item_done();
        end
    endtask

endclass

