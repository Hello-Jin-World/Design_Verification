`timescale 1ns/1ns

class axi_one_tx_sequence extends uvm_sequence #(axi_seq_item);
    `uvm_object_utils(axi_one_tx_sequence)

    function new(string name = "axi_one_tx_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info("AXI_SEQ", "Sequence body started", UVM_LOW);
        req = axi_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {
            is_read == 0; // Write transaction
            awaddr == 32'h0000;
            wdata == 32'hDEADBEEF;
        });
        finish_item(req);
        `uvm_info("AXI_SEQ", "Sequence body finished", UVM_LOW);
    endtask
endclass
