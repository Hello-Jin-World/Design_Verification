`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: my_test
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

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env env;

    function new(string name="my_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        env = my_env::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        apb_sequence seq = apb_sequence::type_id::create("seq");
        seq.start(env.apb.sequencer);

        phase.drop_objection(this);
    endtask

endclass

