import riscv_pkg::*;

module prog_cnt (
    input  logic clk,
    input logic [1:0] pc_cd, 
    input logic [31:0] e_rd, jalr_counter,
    output logic [31:0] program_counter
);

  always_ff @(posedge clk) begin 
    case (pc_cd)
      PC_JAL:  program_counter <= program_counter + 1 + ($signed(e_rd) >>> 2);  
      PC_JALR: program_counter <= jalr_counter + ($signed(e_rd) >>> 2);
      default: program_counter = program_counter + 1;
    endcase
                        
  end
endmodule


