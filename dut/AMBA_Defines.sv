typedef enum logic [2:0] {
    IDLE         = 3'b000,
    // WRITE
    WAIT_AWADDR  = 3'b001,
    WAIT_WDATA   = 3'b010,
    WRITE_SETUP  = 3'b011,
    WRITE_ACCESS = 3'b100,
    // READ
    READ_SETUP   = 3'b101,
    READ_ACCESS  = 3'b110
} axi_state_t;
