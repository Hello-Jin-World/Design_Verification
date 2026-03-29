`include "AMBA_Defines.sv"

module AXI2APB(
    input  logic        ACLK,
    input  logic        ARESETn,
    //// AXI4 SLAVE
    // AW Channel
    input  logic [ 4:0] AWID,
    input  logic [31:0] AWADDR,
    input  logic [ 3:0] AWLEN,
    input  logic [ 2:0] AWSIZE,
    input  logic [ 1:0] AWBURST,
    input  logic        AWVALID,
    output logic        AWREADY,
    // W Channel
    input  logic [31:0] WDATA,
    input  logic [ 3:0] WSTRB,
    input  logic        WLAST,
    input  logic        WVALID,
    output logic        WREADY,
    // B Channel
    output logic [ 4:0] BID,
    output logic [ 2:0] BRESP,
    output logic        BVALID,
    input  logic        BREADY,
    // AR Channel
    input  logic [ 4:0] ARID,
    input  logic [31:0] ARADDR,
    input  logic [ 3:0] ARLEN,
    input  logic [ 2:0] ARSIZE,
    input  logic [ 1:0] ARBURST,
    input  logic        ARVALID,
    output logic        ARREADY,
    // R Channel
    output logic [ 4:0] RID,
    output logic [31:0] RDATA,
    output logic [ 2:0] RRESP, 
    output logic        RLAST,
    output logic        RVALID,
    input  logic        RREADY,

    //// APB MASTER 
    output logic        PSEL,
    output logic [31:0] PADDR,
    output logic [31:0] PWDATA,
    input  logic [31:0] PRDATA,
    output logic        PWRITE,
    output logic        PENABLE,
    input  logic        PREADY,
    input  logic        PSLVERR
);
    axi_state_t axi_state;
    axi_state_t axi_next_state;

    // AW Channel
    reg        awready_reg;
    // W Channel
    reg        wready_reg;
    // B Channel
    reg [ 4:0] bid_reg;
    reg [ 2:0] bresp_reg;
    reg        bvalid_reg;
    // AR Channel
    reg        arready_reg;
    // R Channel
    reg [ 4:0] rid_reg;
    reg [31:0] rdata_reg;
    reg [ 2:0] rresp_reg; 
    reg        rlast_reg;
    reg        rvalid_reg;

    // APB MASTER 
    reg        psel_reg;
    reg [31:0] paddr_reg;
    reg [31:0] pwdata_reg;
    reg        pwrite_reg;
    reg        penable_reg;
                      
    always_ff @(posedge ACLK, negedge ARESETn) begin
        if (!ARESETn) begin
            axi_state   <= IDLE;
            awready_reg <= 0;
            wready_reg  <= 0;
            bid_reg     <= 0;
            bresp_reg   <= 0;
            bvalid_reg  <= 0;
            arready_reg <= 0;
            rid_reg     <= 0;
            rdata_reg   <= 0;
            rresp_reg   <= 0; 
            rlast_reg   <= 0;
            rvalid_reg  <= 0;
            psel_reg    <= 0;
            paddr_reg   <= 0;
            pwdata_reg  <= 0;
            pwrite_reg  <= 0;
            penable_reg <= 0;
        end else begin
            axi_state <= axi_next_state;
        end
    end

    always_comb begin
        axi_next_state = axi_state;

        case (axi_state)
            IDLE : begin
                // AXI
                awready_reg = 1;
                wready_reg  = 1;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 1;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;
                psel_reg    = 0;
                paddr_reg   = 0;
                pwdata_reg  = 0;
                pwrite_reg  = 0;
                penable_reg = 0;

                // APB
                if (WVALID) begin
                    pwdata_reg = WDATA;
                end

                if (AWVALID) begin // Write Priority
                    paddr_reg = AWADDR;
                end else begin
                    if (ARVALID) begin
                        paddr_reg = ARADDR;
                    end 
                end 
            end
            WAIT_AWADDR : begin
                // AXI
                awready_reg = 1;
                wready_reg  = 0;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;

                // APB
                if (AWVALID) begin
                    paddr_reg = AWADDR;
                end 
            end
            WAIT_WDATA : begin
                // AXI
                awready_reg = 0;
                wready_reg  = 1;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;

                // APB
                if (WVALID) begin
                    pwdata_reg = WDATA;
                end
            end
            WRITE_SETUP : begin // like APB's SETUP
                // AXI
                awready_reg = 0;
                wready_reg  = 0;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;
                // APB
                psel_reg    = paddr_reg[0];
                //paddr_reg   = 0; Already assigned paddr at IDLE state
                //pwdata_reg  = 0; Already assigned pwdata at IDLE/WAIT_WDATA state
                pwrite_reg  = 1; // write
                penable_reg = 0;
            end
            WRITE_ACCESS : begin
                // AXI
                awready_reg = 0;
                wready_reg  = 0;
                bid_reg     = 0;
                bresp_reg   = PSLVERR;
                bvalid_reg  = 1;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;

                penable_reg = 1;
            end
            READ_SETUP : begin
                // AXI
                awready_reg = 0;
                wready_reg  = 0;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = 0;
                rresp_reg   = 0; 
                rlast_reg   = 0;
                rvalid_reg  = 0;
                // APB
                psel_reg    = paddr_reg[0];
                //paddr_reg   = 0; Already assigned paddr at IDLE state
                //pwdata_reg  = 0; Already assigned pwdata at IDLE/WAIT_WDATA state
                pwrite_reg  = 0; // read 
                penable_reg = 0;
            end
            READ_ACCESS : begin
                // AXI
                awready_reg = 0;
                wready_reg  = 0;
                bid_reg     = 0;
                bresp_reg   = 0;
                bvalid_reg  = 0;
                arready_reg = 0;
                rid_reg     = 0;
                rdata_reg   = PRDATA;
                rresp_reg   = PSLVERR; 
                rlast_reg   = 1;
                rvalid_reg  = 0;

                penable_reg = 1;
            end
        endcase

        case (axi_state)
            IDLE : begin
                if (AWVALID || WVALID) begin
                    // WRITE TRANSACTION
                    case ({AWVALID, WVALID}) 
                        2'b00   : axi_next_state = IDLE;
                        2'b01   : axi_next_state = WAIT_AWADDR;
                        2'b10   : axi_next_state = WAIT_WDATA;
                        2'b11   : axi_next_state = WRITE_SETUP;
                        default : axi_next_state = IDLE;
                    endcase
                end
                else begin // if (ARVALID == 1)
                    if (ARVALID) begin
                        // READ TRANSACTION
                        axi_next_state = READ_SETUP;
                    end 
                end
            end
            // WRITE
            WAIT_AWADDR : begin
                if (AWVALID) begin
                    axi_next_state = WRITE_SETUP;
                end else begin
                    axi_next_state = WAIT_AWADDR;
                end
            end
            WAIT_WDATA : begin
                if (WVALID) begin
                    axi_next_state = WRITE_SETUP;
                end else begin
                    axi_next_state = WAIT_WDATA;
                end
            end
            WRITE_SETUP : begin
                axi_next_state = WRITE_ACCESS; 
            end
            WRITE_ACCESS : begin
                if (PREADY) begin
                    axi_next_state = IDLE; 
                end else begin
                    axi_next_state = WRITE_ACCESS; 
                end 
            end 
            // READ
            READ_SETUP : begin
                axi_next_state = READ_ACCESS;
            end 
            READ_ACCESS : begin
                if (PREADY) begin
                    axi_next_state = IDLE; 
                end else begin
                    axi_next_state = READ_ACCESS; 
                end 
            end 
        endcase
    end

    assign AWREADY = awready_reg;                
    assign WREADY  = wready_reg;                
    assign BID     = bid_reg;                
    assign BRESP   = bresp_reg;                
    assign BVALID  = bvalid_reg;                
    assign ARREADY = arready_reg;                
    assign RID     = rid_reg;                
    assign RDATA   = rdata_reg;                
    assign RRESP   = rresp_reg;                 
    assign RLAST   = rlast_reg;                
    assign RVALID  = rvalid_reg;                
    assign PSEL    = psel_reg;                        
    assign PADDR   = paddr_reg;               
    assign PWDATA  = pwdata_reg;               
    assign PWRITE  = pwrite_reg;               
    assign PENABLE = penable_reg;               


endmodule



















  //    if (w_state == `IDLE && r_state == `IDLE) begin
  //        if (AWVALID) begin
  //            w_next_state = `SETUP;
  //            awready_reg = 1;
  //            wready_reg = 1;
  //            w_priority = 1;
  //            end
  //        end else if (WVALID) begin
  //            w_next_state = `SETUP;
  //            awready_reg = 1;
  //            wready_reg = 1;
  //            w_priority = 1;
  //        end else if (ARVALID) begin
  //            r_next_state = `SETUP;
  //            arready_reg = 1;
  //        end
  //    end

  //    // Write state machine
  //    case(w_state)
  //        `SETUP: begin
  //            psel_reg = 1;
  //            pwrite_reg = 1;
  //            paddr_reg = AWADDR;
  //            pwdata_reg = WDATA;
  //            w_next_state = `ACCESS;
  //            w_priority = 1;
  //        end
  //        `ACCESS: begin
  //            psel_reg = 1;
  //            penable_reg = 1;
  //            pwrite_reg = 1;
  //            if (PREADY) begin
  //                bvalid_reg = 1;
  //                bresp_reg = PSLVERR ? 2'b10 : 2'b00;
  //                w_next_state = `IDLE;
  //            end
  //            w_priority = 1;
  //        end
  //    endcase

  //    // Read state machine
  //    if (!w_priority) begin
  //        case(r_state)
  //            `SETUP: begin
  //                psel_reg = 1;
  //                pwrite_reg = 0;
  //                paddr_reg = ARADDR;
  //                r_next_state = `ACCESS;
  //            end
  //            `ACCESS: begin
  //                psel_reg = 1;
  //                penable_reg = 1;
  //                pwrite_reg = 0;
  //                if (PREADY) begin
  //                    rvalid_reg = 1;
  //                    rlast_reg = 1;
  //                    rresp_reg = PSLVERR ? 2'b10 : 2'b00;
  //                    r_next_state = `IDLE;
  //                end
  //            end
  //        endcase
  //    end

  //  //if (BREADY) begin
  //  //    bvalid_reg = 0;
  //  //end

  //    if (RREADY) begin
  //        rvalid_reg = 0;
  //        rlast_reg = 0;
  //    end
  //end

  //assign AWREADY = awready_reg;
  //assign WREADY = wready_reg;
  //assign BVALID = bvalid_reg;
  //assign BID = AWID;
  //assign BRESP = bresp_reg;

  //assign ARREADY = arready_reg;
  //assign RVALID = rvalid_reg;
  //assign RLAST = rlast_reg;
  //assign RID = ARID;
  //assign RRESP = rresp_reg;
  //assign RDATA = PRDATA;

  //assign PADDR = paddr_reg;
  //assign PWRITE = pwrite_reg;
  //assign PSEL = psel_reg;
  //assign PENABLE = penable_reg;
