
module instruction_memory (
    input logic [31:0] im_a,
    output logic [31:0] im_rd 
);

    logic [31:0] inst [0:31];                  

    initial begin
        $readmemh("instructions.txt", inst);
    end

    assign im_rd = inst[im_a]; 

endmodule