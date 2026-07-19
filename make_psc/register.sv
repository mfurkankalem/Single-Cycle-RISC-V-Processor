

module register (
    input  logic clk, r_cd,
    input  logic [4:0]  r_a1,
    input  logic [4:0]  r_a2,
    input  logic [4:0]  r_a3,
    input  logic [31:0] r_wd3,
    output logic [31:0] r_rd1,
    output logic [31:0] r_rd2
);

logic [31:0] register [0:31];

assign r_rd1 = register[r_a1];
assign r_rd2 = register[r_a2];

  always @(posedge clk) begin
  
    if(r_cd==1) begin
      register[r_a3] = r_wd3;
      register[r_a1] = register[r_a1]+1; //fake
    end

  end
endmodule


