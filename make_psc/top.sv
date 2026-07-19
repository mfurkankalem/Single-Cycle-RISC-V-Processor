

module top (input logic clk);
logic [4:0] r_a1, r_a3;
logic [4:0] r_a2 = 5'd4;                  //fake
logic [31:0] r_rd1, r_rd2;
logic r_we3 = 1;                          //fake
logic dm_we = 1;                          //fake
//logic [31:0] r_wd3 = 32'hFFC4A303;      //fake
logic [31:0] r_wd3;

logic [24:0] e_a;
logic [1:0] e_cd = 2'b01;                 //fake
logic [31:0] e_rd;

logic [31:0] dm_a, dm_wd, dm_rd;
logic [31:0] im_a;
logic [31:0] im_rd= 32'b1000000_10001_00101_000_00011_0000000;   //fake


register r_0(.clk(clk), .r_we3(r_we3), .r_a1(r_a1), .r_a2(r_a2), .r_a3(r_a3),
 .r_wd3(r_wd3), .r_rd1(r_rd1), .r_rd2(r_rd2));

extender e_0(.e_a(e_a), .e_cd(e_cd), .e_rd(e_rd));

data_memory m_data(.clk(clk), .dm_a(dm_a), .dm_wd(dm_wd), .dm_we (dm_we),
  .dm_rd(dm_rd));

// instruction_memory m_inst(.im_a(im_a), .im_rd(im_rd));

assign dm_wd = r_rd2;       //
assign dm_a = r_rd1;        //
assign r_wd3 = dm_rd;       //
assign e_a = im_rd[31:7];
assign r_a1 = im_rd[19:15];
assign r_a3 = im_rd[11:7];



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


