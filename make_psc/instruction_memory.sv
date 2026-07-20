

module instruction_memory (
    input logic [31:0] im_a,
    output logic [31:0] im_rd 
);

logic [31:0] inst [0:15];                  //fake sonra 128

//fake
assign inst[0] = 32'b0000001_00011_00000_000_00000_0010011; //addi x0 x0 35 
assign inst[1] = 32'b0000000_00011_00000_000_00001_0010011; //addi x1 x0 3 
assign inst[2] = 32'b0000000_00000_00001_000_00010_0110011; //add x2 x1 x0
assign inst[3] = 32'b0000000_00001_00011_000_00011_0010011; //addi x3 x3 1 
assign inst[4] = 32'b0000000_00010_00011_010_00001_0100011; //sw x2, 1(x3)
assign inst[5] = 32'b0000000_00001_00011_010_00100_0000011; //lw x4, 1(x3)
assign inst[6] = 32'b0000000_00101_00111_000_00100_0000000; //
//fake

assign im_rd = inst[im_a]; 


endmodule