`timescale 1ns/1ns

class axi_agent extends uvm_agent;
    `uvm_component_utils(axi_agent)

    axi_driver    driver;
    uvm_sequencer #(axi_seq_item) seqr;

    function new(string name = "axi_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        seqr = uvm_sequencer#(axi_seq_item)::type_id::create("seqr", this);
        driver = axi_driver::type_id::create("driver", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass
