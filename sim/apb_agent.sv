class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  function new(string name = "apb_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  apb_driver drv;
  uvm_sequencer #(apb_seq_item) seqr;
  apb_monitor mon;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seqr = uvm_sequencer#(apb_seq_item)::type_id::create("seqr", this);
    drv  = apb_driver::type_id::create("drv", this);
    mon  = apb_monitor::type_id::create("mon", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
