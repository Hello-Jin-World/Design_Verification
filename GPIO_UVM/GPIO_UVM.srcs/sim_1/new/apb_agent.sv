`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_agent
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

class apb_agent extends uvm_agent;

    `uvm_component_utils(apb_agent)

    apb_sequencer sequencer;
    apb_driver    driver;
    apb_monitor   monitor;

    function new(string name="apb_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sequencer = apb_sequencer::type_id::create("sequencer", this);
        driver    = apb_driver   ::type_id::create("driver", this);
        monitor   = apb_monitor  ::type_id::create("monitor", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass

