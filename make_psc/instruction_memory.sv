

module instruction_memory (
    input logic [31:0] im_a,
    output logic [31:0] im_rd 
);

logic [31:0] inst [0:15];                  //fake sonra 128

//fake
assign inst[0] = 32'b0000000_01000_00011_000_00101_0000000;  
assign inst[1] = 32'b0000000_01010_00011_000_00101_0000000;
assign inst[2] = 32'b0000000_01011_00011_000_00101_0000000;
//fake

assign im_rd = inst[im_a]; 


endmodule