class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)

    function new(string name = "apb_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual apb_if vif;
    uvm_analysis_port #(apb_seq_item) ap;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Could not get vif")
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(vif.mon_cb);
            if(vif.mon_cb.PSEL && vif.mon_cb.PENABLE && vif.mon_cb.PREADY) begin
                apb_seq_item tr = apb_seq_item::type_id::create("tr");
                tr.write = vif.mon_cb.PWRITE;
                tr.addr  = vif.mon_cb.PADDR;
                if (tr.write) begin
                    tr.data = vif.mon_cb.PWDATA;
                end else begin
                    tr.data = vif.mon_cb.PRDATA;
                end
            end
        end
    endtask
endclass
