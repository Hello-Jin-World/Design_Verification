`timescale 1ns/1ns

class axi_one_tx_test extends uvm_test;
    `uvm_component_utils(axi_one_tx_test)

    axi_env env; // We will modify apb_env to contain the AXI agent

    function new(string name = "axi_one_tx_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = axi_env::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        axi_one_tx_sequence seq;
        phase.raise_objection(this);
        seq = axi_one_tx_sequence::type_id::create("seq");
        seq.start(env.agent.seqr); // We'll add axi_agent to apb_env
        phase.drop_objection(this);
    endtask
endclass
