

module ALU (
    input  logic [31:0] alu_a, alu_b,
    input  logic [2:0] alu_cd, 
    output logic [31:0] alu_rd
);

  always_comb begin
    if (alu_cd==3'b001)
      alu_rd = alu_a | alu_b;
    else if (alu_cd==3'b010)
      alu_rd = alu_a;
    else if (alu_cd==3'b011)
      alu_rd = alu_b;
    else if (alu_cd==3'b100)
      alu_rd = alu_a + alu_b;
    else
      alu_rd = 0;

  end
endmodule


