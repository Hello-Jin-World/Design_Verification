`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2025 04:08:38 PM
// Design Name: 
// Module Name: apb_seq_item
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

class apb_seq_item extends uvm_sequence_item;

    rand bit [31:0] addr;
    rand bit [31:0] data;
    rand bit        write;

    `uvm_object_utils(apb_seq_item)

    function new(string name="apb_seq_item");
        super.new(name);
    endfunction

endclass

