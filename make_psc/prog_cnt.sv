

module prog_cnt (
    input  logic clk, 
    output logic [31:0] program_counter
);

  always_ff @(posedge clk) begin 
    program_counter = program_counter + 1;                       
  end

endmodule


