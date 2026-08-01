import riscv_pkg::*;

module prog_cnt (
    input  logic clk,
    input logic [1:0] pc_cd, 
    input logic [31:0] e_rd, jalr_counter, branch_rd,
    output logic [31:0] program_counter
);

  always_ff @(posedge clk) begin 
    case (pc_cd)
      PC_JAL:    program_counter = branch_rd + ($signed(e_rd) >>> 2);  
      PC_JALR:   program_counter = jalr_counter + ($signed(e_rd) >>> 2);
      PC_BRANCH: program_counter = branch_rd;
      default:   program_counter = branch_rd + 1;
    endcase
                        
  end
endmodule


