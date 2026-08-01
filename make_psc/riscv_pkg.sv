

package riscv_pkg;

    typedef enum logic [3:0] {
        ALU_ADD  = 4'b0000,
        ALU_SUB  = 4'b0001,
        ALU_AND  = 4'b0010,
        ALU_OR   = 4'b0011,
        ALU_XOR  = 4'b0100,
        ALU_SLL  = 4'b0101,
        ALU_SRL  = 4'b0110,
        ALU_SRA  = 4'b0111,
        ALU_SLT  = 4'b1000,
        ALU_SLTU = 4'b1001,
        ALU_NONE = 4'b1111
    } alu_op_e;

    typedef enum logic [2:0] {
        IMM_NONE = 3'b000,   // R-type: no immediate
        IMM_I    = 3'b001,   // I-type operations
        IMM_J    = 3'b010,   // J-type operations
        IMM_U    = 3'b011,   // U-type operations
        IMM_S    = 3'b100,   // S-type operations
        IMM_B    = 3'b101    // B-type operations
    } imm_src_e;

    typedef enum logic [9:0] {
        CTRL_REG_WRITE   = 10'b00_1_0_00_0_01_0,   // add, sub
        CTRL_REG_WRITE_I = 10'b00_1_1_00_0_01_0,   // addi
        CTRL_JUMP_LINK   = 10'b01_1_0_10_0_01_0,   // jal
        CTRL_JALR        = 10'b10_1_1_10_0_10_0,   // jalr
        CTRL_BRANCH      = 10'b11_0_0_00_0_11_0,   // branch 
        CTRL_LOAD        = 10'b00_1_1_01_0_00_0,   // lw
        CTRL_STORE       = 10'b00_0_1_00_1_00_1,   // sw
        CTRL_NONE        = 10'b00_0_1_00_0_01_0
    } ctrl_e;

    typedef enum logic [1:0] {
        PC_NONE   = 2'b00,   
        PC_JAL    = 2'b01,   
        PC_JALR   = 2'b10,
        PC_BRANCH = 2'b11 
    } pc_e;

endpackage