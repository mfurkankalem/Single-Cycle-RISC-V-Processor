import riscv_pkg::*;

module ALU (
    input  logic [31:0] alu_a, alu_b,
    input  logic [2:0] alu_cd, 
    output logic [31:0] alu_rd
);

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


