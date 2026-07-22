

module ALU (
    input  logic [31:0] alu_a, alu_b,
    input  logic [2:0] alu_cd, 
    output logic [31:0] alu_rd
);

  typedef enum logic [2:0] {
        ALU_ADD = 3'b000,
        ALU_SUB = 3'b001,
        ALU_AND = 3'b010,
        ALU_OR  = 3'b011
    } alu_op_e;

    always_comb begin
        case (alu_cd)
            ALU_ADD: alu_rd = alu_a + alu_b;
            ALU_SUB: alu_rd = alu_a - alu_b;
            ALU_AND: alu_rd = alu_a & alu_b;
            ALU_OR:  alu_rd = alu_a | alu_b;
            default: alu_rd = '0;
        endcase
    end

endmodule


