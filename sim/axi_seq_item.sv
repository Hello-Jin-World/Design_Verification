import uvm_pkg::*;

class axi_seq_item extends uvm_sequence_item;
    `uvm_object_utils(axi_seq_item)

    // AXI random transaction variables
    rand bit [31:0] awaddr;
    rand bit [31:0] wdata;
    rand bit [31:0] araddr;
    bit [31:0] rdata;

    // Read or Write
    rand bit is_read;

    function new(string name = "axi_seq_item");
        super.new(name);
    endfunction

    constraint c_addr {
        // Define address constraints if necessary
        awaddr inside {16'h0000, 16'h0004, 16'h0008, 16'h000C, 16'h0010};
    }

endclass
