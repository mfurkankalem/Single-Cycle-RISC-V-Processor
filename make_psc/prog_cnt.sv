import riscv_pkg::*;

module prog_cnt (
    input  logic clk,
    input logic [1:0] pc_cd, 
    input logic [31:0] e_rd,
    output logic [31:0] program_counter
);

  always_ff @(posedge clk) begin 
    case (pc_cd)
      PC_JAL:  program_counter = program_counter + e_rd;  
      PC_JALR: program_counter = program_counter + e_rd; 
      default: program_counter = program_counter + 1;  
    endcase
                        
  end
endmodule


