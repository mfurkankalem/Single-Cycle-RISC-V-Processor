

module instruction_memory (
    input logic [31:0] im_a,
    output logic [31:0] im_rd 
);

logic [31:0] inst [0:7];                  //fake sonra 128
//fake ayrıca komut yükleme sistemi olcak

assign im_rd = inst[im_a];

endmodule