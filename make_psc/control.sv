

module control (
    input  logic [6:0] op,
    input  logic [2:0] funct3, 
    input logic [6:0] funct7,
    output logic r_cd, dm_cd, m_cd1, m_cd2, d_cd1, d_cd2,
    output  logic [1:0] e_cd,
    output  logic [2:0] alu_cd 
);

    localparam logic [16:0]
        // R-type
        P_ADD   = 17'b0110011_000_0000000,
        P_SUB   = 17'b0110011_000_0100000,
        P_SLL   = 17'b0110011_001_0000000,
        P_SLT   = 17'b0110011_010_0000000,
        P_SLTU  = 17'b0110011_011_0000000,
        P_XOR   = 17'b0110011_100_0000000,
        P_SRL   = 17'b0110011_101_0000000,
        P_SRA   = 17'b0110011_101_0100000,
        P_OR    = 17'b0110011_110_0000000,
        P_AND   = 17'b0110011_111_0000000,

        // I-type 
        P_ADDI  = 17'b0010011_000_???????,
        P_SLTI  = 17'b0010011_010_???????,
        P_SLTIU = 17'b0010011_011_???????,
        P_XORI  = 17'b0010011_100_???????,
        P_ORI   = 17'b0010011_110_???????,
        P_ANDI  = 17'b0010011_111_???????,
        P_SLLI  = 17'b0010011_001_0000000,
        P_SRLI  = 17'b0010011_101_0000000,
        P_SRAI  = 17'b0010011_101_0100000,

        // Load
        P_LB    = 17'b0000011_000_???????,
        P_LH    = 17'b0000011_001_???????,
        P_LW    = 17'b0000011_010_???????,
        P_LBU   = 17'b0000011_100_???????,
        P_LHU   = 17'b0000011_101_???????,

        // Store
        P_SB    = 17'b0100011_000_???????,
        P_SH    = 17'b0100011_001_???????,
        P_SW    = 17'b0100011_010_???????,

        // Branch
        P_BEQ   = 17'b1100011_000_???????,
        P_BNE   = 17'b1100011_001_???????,
        P_BLT   = 17'b1100011_100_???????,
        P_BGE   = 17'b1100011_101_???????,
        P_BLTU  = 17'b1100011_110_???????,
        P_BGEU  = 17'b1100011_111_???????,

        // Jump
        P_JALR  = 17'b1100111_000_???????,
        P_JAL   = 17'b1101111_???_???????,

        // U-type
        P_LUI   = 17'b0110111_???_???????,
        P_AUIPC = 17'b0010111_???_???????,

        // Misc-mem / system
        P_FENCE = 17'b0001111_000_???????,
        P_SYS   = 17'b1110011_000_0000000;  

    typedef enum logic [5:0] {
        OP_ADD, OP_SUB, OP_SLL, OP_SLT, OP_SLTU, OP_XOR, OP_SRL, OP_SRA, OP_OR, OP_AND,
        OP_ADDI, OP_SLTI, OP_SLTIU, OP_XORI, OP_ORI, OP_ANDI, OP_SLLI, OP_SRLI, OP_SRAI,
        OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU,
        OP_SB, OP_SH, OP_SW,
        OP_BEQ, OP_BNE, OP_BLT, OP_BGE, OP_BLTU, OP_BGEU,
        OP_JALR, OP_JAL, OP_LUI, OP_AUIPC,
        OP_FENCE, OP_ECALL, OP_EBREAK,
        OP_INVALID
    } command_e;

    logic [16:0] casecode;
    assign casecode = {op, funct3, funct7};

    always_comb begin
        casez (casecode)
            P_ADD: begin
                r_cd   = 1'b1;
                e_cd   = 2'b00;
                alu_cd = 3'b000;
                m_cd1  = 1'b0;
                m_cd2  = 1'b0;
                d_cd1  = 1'b0;
                d_cd2  = 1'b1;
                dm_cd  = 1'b0;
            end
            P_SUB: begin
                r_cd   = 1'b1;
                e_cd   = 2'b00;
                alu_cd = 3'b001;
                m_cd1  = 1'b0;
                m_cd2  = 1'b0;
                d_cd1  = 1'b0;
                d_cd2  = 1'b1;
                dm_cd  = 1'b0;
            end
            P_ADDI: begin
                r_cd   = 1'b1;
                e_cd   = 2'b01;
                alu_cd = 3'b000;
                m_cd1  = 1'b1;
                m_cd2  = 1'b0;
                d_cd1  = 1'b0;
                d_cd2  = 1'b1;
                dm_cd  = 1'b0;
            end
            P_SW: begin
                r_cd   = 1'b0;
                e_cd   = 2'b10;
                alu_cd = 3'b000;
                m_cd1  = 1'b1;
                m_cd2  = 1'b0;
                d_cd1  = 1'b1;
                d_cd2  = 1'b0;
                dm_cd  = 1'b1;
            end
            P_LW: begin
                r_cd   = 1'b1;
                e_cd   = 2'b01;
                alu_cd = 3'b000;
                m_cd1  = 1'b1;
                m_cd2  = 1'b1;
                d_cd1  = 1'b0;
                d_cd2  = 1'b0;
                dm_cd  = 1'b0;
            end
            default: begin
                r_cd   = 1'b0;
                e_cd   = 2'b00;
                alu_cd = 3'b111;
                m_cd1  = 1'b1;
                m_cd2  = 1'b0;
                d_cd1  = 1'b0;
                d_cd2  = 1'b1;
                dm_cd  = 1'b0;
            end
        endcase
    end


endmodule


