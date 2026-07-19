module mux (
  input logic [31:0] a1, a2,
  input logic m_cd,  
  output logic [31:0] m_rd
);
  always_comb begin
    if(m_cd==0)
      m_rd = a1;
    else
      m_rd = a2;
  end
endmodule

module demux (
  input logic [31:0] a1,
  input logic d_cd,  
  output logic [31:0] rd1, rd2
);
  always_comb begin
    if(d_cd==0) begin
      rd1 = a1;
      rd2 = 0;
    end
    else begin
      rd1 = 0;
      rd2 = a1;
    end
  end
endmodule

module top (input logic clk);
logic [31:0] program_counter;

logic [4:0] r_a1, r_a2, r_a3;
logic [31:0] r_rd1, r_rd2, r_wd3;

logic [24:0] e_a;
logic [31:0] e_rd;
logic [31:0] alu_a, alu_b, alu_rd;

logic r_cd, dm_cd, m_cd1, m_cd2, d_cd1, d_cd2;
logic [1:0] e_cd;
logic [2:0] alu_cd;


logic [31:0] dm_a, dm_rd, dm_wd;
logic [31:0] im_rd;

prog_cnt pc_0(.clk(clk), .program_counter(program_counter));

register r_0(.clk(clk), .r_cd(r_cd), .r_a1(r_a1), .r_a2(r_a2), .r_a3(r_a3),
 .r_wd3(r_wd3), .r_rd1(r_rd1), .r_rd2(r_rd2));

extender e_0(.e_a(e_a), .e_cd(e_cd), .e_rd(e_rd));

ALU alu_0(.alu_a(alu_a), .alu_b(alu_b), .alu_cd(alu_cd), .alu_rd(alu_rd));

data_memory m_data(.clk(clk), .dm_cd(dm_cd), .dm_a(dm_a), .dm_wd (dm_wd),
  .dm_rd(dm_rd));

control c_0(.op(im_rd[6:0]), .funct3(im_rd[14:12]), .funct7(im_rd[31:25]),
.r_cd(r_cd), .dm_cd(dm_cd), .m_cd1(m_cd1), .m_cd2(m_cd2), .d_cd1(d_cd1),
.d_cd2(d_cd2), .e_cd(e_cd), .alu_cd(alu_cd));

instruction_memory m_inst(.im_a(program_counter), .im_rd(im_rd));   


assign e_a = im_rd[31:7];
assign r_a1 = im_rd[19:15];
assign r_a2 = im_rd[24:20];
assign r_a3 = im_rd[11:7];
assign alu_a = r_rd1;

mux mux_1 (.a1(demux1_out1), .a2(e_rd), .m_cd(m_cd1), .m_rd(alu_b));
mux mux_2 (.a1(demux2_out2), .a2(dm_rd), .m_cd(m_cd2), .m_rd(r_wd3));

logic [31:0] demux1_out1, demux2_out2;
demux demux_1 (.a1(r_rd2), .d_cd(d_cd1), .rd1(demux1_out1), .rd2(dm_wd));
demux demux_2 (.a1(alu_rd), .d_cd(d_cd2), .rd1(dm_a), .rd2(demux2_out2));





  final begin
    $display("Simulasyon bitti. Toplam çalışma süresi : %0t", $time);
    $display("Register 1 output : %0h", r_rd1);
    $display("Register 2 output : %0h", r_rd2);
  end

endmodule


