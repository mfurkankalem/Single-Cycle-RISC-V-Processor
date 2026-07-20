

module control (
    input  logic [6:0] op,
    input  logic [2:0] funct3, 
    input logic [6:0] funct7,
    output logic r_cd, dm_cd, m_cd1, m_cd2, d_cd1, d_cd2,
    output  logic [1:0] e_cd,
    output  logic [2:0] alu_cd 
);

  always_comb begin
    if (op==7'd19 & funct3==0) begin //addi
        r_cd = 1;
        e_cd = 2'b01;
        alu_cd = 3'b000;
        m_cd1 = 1;
        m_cd2 = 0;
        d_cd1 = 0;
        d_cd2 = 1;
        dm_cd = 0;
    end
    else if (op==7'd51 & funct3==0 & funct7==0) begin //add
        r_cd = 1;
        e_cd = 2'b00;
        alu_cd = 3'b000;
        m_cd1 = 0;
        m_cd2 = 0;
        d_cd1 = 0;
        d_cd2 = 1;
        dm_cd = 0;
    end
    else if (op==7'd51 & funct3==0 & funct7==7'b0100000) begin //sub
        r_cd = 1;
        e_cd = 2'b00;
        alu_cd = 3'b001;   
        m_cd1 = 0;
        m_cd2 = 0;
        d_cd1 = 0;
        d_cd2 = 1;
        dm_cd = 0;
    end
    else if (op==7'd35 & funct3==3'b010) begin //sw
        r_cd = 0;
        e_cd = 2'b10;
        alu_cd = 3'b000;
        m_cd1 = 1;
        m_cd2 = 0;
        d_cd1 = 1;
        d_cd2 = 0;
        dm_cd = 1;
    end
    else if (op==7'd3 & funct3==3'b010) begin //lw
        r_cd = 1;
        e_cd = 2'b01;
        alu_cd = 3'b000;
        m_cd1 = 1;
        m_cd2 = 1;
        d_cd1 = 0;
        d_cd2 = 0;
        dm_cd = 0;
    end
    else begin
        r_cd = 0;
        e_cd = 2'b00;
        alu_cd = 3'b111;
        m_cd1 = 1;
        m_cd2 = 0;
        d_cd1 = 0;
        d_cd2 = 1;
        dm_cd = 0;
    end
  end

endmodule


