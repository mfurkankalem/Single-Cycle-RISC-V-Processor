

module top (input logic clk);
logic [4:0] r_a1 = 5'd5;                  //fake
logic [4:0] r_a2 = 5'd3;                  //fake
logic [4:0] r_a3 = 5'd6;                  //fake
logic [31:0] r_rd1, r_rd2;
logic r_we3 = 1;                          //fake
logic dm_we = 1;                          //fake
//logic [31:0] r_wd3 = 32'hFFC4A303;      //fake
logic [31:0] r_wd3;

logic [31:0] dm_a, dm_wd, dm_rd;
logic [31:0] im_rd;
logic [31:0] im_a = 32'b0000000_00000_00000_000_00000_0000000;


register r_0(.clk(clk), .r_we3(r_we3), .r_a1(r_a1), .r_a2(r_a2), .r_a3(r_a3),
 .r_wd3(r_wd3), .r_rd1(r_rd1), .r_rd2(r_rd2));

data_memory m_data(.clk(clk), .dm_a(dm_a), .dm_wd(dm_wd), .dm_we (dm_we),
  .dm_rd(dm_rd));

instruction_memory m_inst(.im_a(im_a), .im_rd(im_rd));

assign dm_wd = r_rd2;
assign dm_a = r_rd1;
assign r_wd3 = dm_rd;

  always_ff @(posedge clk) begin 
    r_we3 = ~r_we3;                       //fake
  end

  always_ff @(negedge clk) begin
    dm_we = ~dm_we;                       //fake
  end

  final begin
    $display("Simulasyon bitti. Toplam çalışma süresi : %0t", $time);
    $display("Yazım sonucu : %0h", r_rd1);
  end

endmodule


