class axi_env extends uvm_env;
    `uvm_component_utils(axi_env)

    function new(string name = "axi_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    axi_agent agent;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = axi_agent::type_id::create("axi_agent", this);
    endfunction
endclass

