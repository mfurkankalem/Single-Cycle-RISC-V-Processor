

module extender (
    input  logic [24:0] e_a,
    input  logic [1:0] e_cd, 
    output logic [31:0] e_rd
);

  always_comb begin
    e_rd = 32'b0;
    if(e_cd==2'b01) begin                       // I-type operations
      e_rd = {{20{e_a[24]}}, e_a[24:13]}; 
    end
    else if (e_cd==2'b10) begin             // S-type operations
      e_rd = {{20{e_a[24]}}, e_a[24:18], e_a[4:0]}; 
    end
    else if (e_cd==2'b11) begin             // U-type operations
      e_rd = {e_a[24:5], 12'b0};
    end
    else
      e_rd = 0;

  end
endmodule


