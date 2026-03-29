class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)

    function new(string name = "apb_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    axi_agent axi_agent;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_agent = axi_agent::type_id::create("axi_agent", this);
    endfunction
endclass
