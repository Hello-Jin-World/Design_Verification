package gpio_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "axi_seq_item.sv"
    //`include "apb_sequencer.sv"
    typedef uvm_sequencer #(axi_seq_item) axi_sequencer;
    `include "axi_driver.sv"
    //`include "apb_monitor.sv"
    `include "axi_agent.sv"
    `include "axi_env.sv"
    //`include "reg_access_seq.sv"
    `include "axi_one_tx_sequence.sv"
    `include "axi_one_tx_test.sv"
endpackage
