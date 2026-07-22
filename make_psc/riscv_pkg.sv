

package riscv_pkg;

    typedef enum logic [2:0] {
        ALU_ADD   = 3'b000,
        ALU_SUB   = 3'b001,
        ALU_AND   = 3'b010,
        ALU_OR    = 3'b011,
        ALU_NONE  = 3'b111
    } alu_op_e;

    typedef enum logic [1:0] {
        IMM_NONE = 2'b00,   // R-type: no immediate
        IMM_I    = 2'b01,   // I-type operations
        IMM_S    = 2'b10,   // S-type operations
        IMM_U    = 2'b11    // U-type operations
    } imm_src_e;

    typedef enum logic [5:0] {
        CTRL_REG_WRITE   = 6'b1_0_0_0_1_0,   // add, sub
        CTRL_REG_WRITE_I = 6'b1_1_0_0_1_0,   // addi
        CTRL_LOAD        = 6'b1_1_1_0_0_0,   // lw
        CTRL_STORE       = 6'b0_1_0_1_0_1,   // sw
        CTRL_NONE        = 6'b0_1_0_0_1_0
    } ctrl_e;

endpackage