

module control (
    input  logic [6:0] op,
    input  logic [2:0] funct3, 
    input logic [6:0] funct7,
    output logic r_cd, dm_cd, m_cd1, m_cd2, d_cd1, d_cd2,
    output  logic [1:0] e_cd,
    output  logic [2:0] alu_cd 
);

//fake
assign e_cd = 2'b01;
assign alu_cd = 3'b001;
assign m_cd1 = 1;
assign d_cd2 = 1;
assign r_cd = 1;
assign dm_cd = 1;
//fake



endmodule


