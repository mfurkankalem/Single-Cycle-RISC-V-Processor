import riscv_pkg::*;

module extender (
    input  logic [24:0] e_a,
    input  logic [1:0] e_cd, 
    output logic [31:0] e_rd
);

  always_comb begin
      case (e_cd)
          IMM_I:   e_rd = {{20{e_a[24]}}, e_a[24:13]};
          IMM_S:   e_rd = {{20{e_a[24]}}, e_a[24:18], e_a[4:0]};
          IMM_U:   e_rd = {e_a[24:5], 12'b0};
          default: e_rd = '0;
      endcase
  end

endmodule


