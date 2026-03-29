class apb_one_tx_sequence extends uvm_sequence #(apb_seq_item);

    `uvm_object_utils(apb_one_tx_sequence)

    function new(string name = "apb_one_tx_sequence");
        super.new(name);
    endfunction

    virtual task body();
        apb_seq_item item;

        bit [15:0] addr_list [5] = '{16'h0000, 16'h0004, 16'h0008, 16'h000C, 16'h0010};
        bit [3:0] con_list [2] = '{4'h0, 4'h1};
        int addr_idx, con_idx;

        repeat (30) begin
            item = apb_seq_item::type_id::create("item");

            addr_idx = $urandom_range(0,4);
            con_idx = $urandom_range(0,1);

            item.addr  = 32'h0;
            item.data  = 32'h0;
            item.write = 1'h0;
            item.addr[15:0] = addr_list[addr_idx];
            if (item.addr[15:0] == 16'h0000) begin
                for (int i = 0; i < 8; i++) begin
                    item.data[4*i +: 4] = con_list[con_idx];
                end
            end
            else if (item.addr[15:0] == 16'h0004) begin
                item.data[7:0] = $urandom();
            end
            else begin
                item.data = $urandom();
            end

            item.write = $urandom();

            start_item(item);
            finish_item(item);

            `uvm_info("SEQ", $sformatf("Send one TX: addr=0x%08h data=0x%08h", item.addr, item.data), UVM_LOW)
        end
    endtask
endclass
