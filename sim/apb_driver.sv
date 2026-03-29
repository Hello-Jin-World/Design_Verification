class apb_driver extends uvm_driver #(apb_seq_item);
    `uvm_component_utils(apb_driver)

    function new(string name = "apb_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual apb_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "No vif")
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_seq_item req;

        `uvm_info("DRV", "run_phase entered", UVM_LOW);

        // IDLE
        vif.PSEL    <= 0;
        vif.PENABLE <= 0;
        vif.PWRITE  <= 0;

        forever begin
            seq_item_port.get_next_item(req);

            // SETUP
            @(posedge vif.PCLK);
            vif.PADDR   <= req.addr;
            vif.PWRITE  <= req.write;
            vif.PWDATA  <= req.data;
            vif.PSEL    <= 1;
            vif.PENABLE <= 0;

            // ACCESS
            wait (vif.PREADY == 1);
            @(posedge vif.PCLK);
            vif.PENABLE <= 1;

            // END
            repeat (10) @(posedge vif.PCLK);
            vif.PSEL    <= 0;
            vif.PENABLE <= 0;

            seq_item_port.item_done();
        end
    endtask
endclass
