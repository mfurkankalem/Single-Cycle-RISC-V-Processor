

module data_memory (
    input logic clk, dm_cd,
    input logic [31:0] dm_a,
    input logic [31:0] dm_wd,
    output logic [31:0] dm_rd 
);

logic [31:0] data [0:7];                  //fake sonra 128

assign dm_rd = data[dm_a];

  always @(posedge clk) begin
  
    if(dm_cd==1) begin
      data[dm_a] = dm_wd;
    end
    
  end

endmodule