import uvm_pkg::*;

class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)

    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction

    rand logic        write;
    rand logic [31:0] addr;
    rand logic [31:0] data;

endclass
