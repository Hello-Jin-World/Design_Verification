class apb_one_tx_test extends uvm_test;
    `uvm_component_utils(apb_one_tx_test)

    function new(string name = "apb_one_tx_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    apb_env env;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = apb_env::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_one_tx_sequence seq;

        `uvm_info("TEST", "run_phase entered", UVM_LOW);
        phase.raise_objection(this);

        seq = apb_one_tx_sequence::type_id::create("seq");
        `uvm_info("TEST", "sequence created", UVM_LOW);
        //seq = new();

        if (env.agent.seqr == null) begin
            `uvm_fatal("TEST", "sequencer is NULL!")
        end

        seq.start(env.agent.seqr);

        `uvm_info("TEST", "sequence finished", UVM_LOW);

        // sequence 끝나면 바로 종료
        phase.drop_objection(this);
    endtask
endclass
