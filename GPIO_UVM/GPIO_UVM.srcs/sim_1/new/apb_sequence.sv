`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_sequence
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

class apb_sequence extends uvm_sequence#(apb_seq_item);

    `uvm_object_utils(apb_sequence)

    function new(string name="apb_sequence");
        super.new(name);
    endfunction

    virtual task body();
        apb_seq_item item = apb_seq_item::type_id::create("item");

        start_item(item);
        assert(item.randomize() with {
            addr inside {[0:100]};
        });
        finish_item(item);
    endtask

endclass

