# assembler.py
import sys

def parse_mem_arg(arg):
    # "1(x3)" gibi bir girdiyi parçalar -> imm: 1, reg: 3
    imm_str, reg_str = arg.split('(')
    imm = int(imm_str)
    reg = int(reg_str.replace('x', '').replace(')', ''))
    return imm, reg

def assemble_addi(args):
    rd = int(args[0].replace('x', ''))
    rs1 = int(args[1].replace('x', ''))
    imm = int(args[2])
    if imm < 0: imm = (1 << 12) + imm
    opcode = "0010011"
    funct3 = "000"
    return f"{format(imm, '012b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def assemble_add(args):
    rd = int(args[0].replace('x', ''))
    rs1 = int(args[1].replace('x', ''))
    rs2 = int(args[2].replace('x', ''))
    opcode = "0110011"
    funct3 = "000"
    funct7 = "0000000"
    return f"{funct7}{format(rs2, '05b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def assemble_subi(args):
    rd = int(args[0].replace('x', ''))
    rs1 = int(args[1].replace('x', ''))
    imm = -int(args[2])   # addi'den tek fark: imm negatifleniyor
    if imm < 0: imm = (1 << 12) + imm
    opcode = "0010011"
    funct3 = "000"
    return f"{format(imm, '012b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def assemble_sub(args):
    rd = int(args[0].replace('x', ''))
    rs1 = int(args[1].replace('x', ''))
    rs2 = int(args[2].replace('x', ''))
    opcode = "0110011"
    funct3 = "000"
    funct7 = "0100000"   # add'de 0000000, sub'da bit farklı
    return f"{funct7}{format(rs2, '05b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def assemble_sw(args):
    rs2 = int(args[0].replace('x', ''))
    imm, rs1 = parse_mem_arg(args[1])
    if imm < 0: imm = (1 << 12) + imm
    opcode = "0100011"
    funct3 = "010"
    imm_bin = format(imm, '012b')
    imm11_5 = imm_bin[0:7]
    imm4_0 = imm_bin[7:12]
    return f"{imm11_5}{format(rs2, '05b')}{format(rs1, '05b')}{funct3}{imm4_0}{opcode}"

def assemble_lw(args):
    rd = int(args[0].replace('x', ''))
    imm, rs1 = parse_mem_arg(args[1])
    if imm < 0: imm = (1 << 12) + imm
    opcode = "0000011"
    funct3 = "010"
    return f"{format(imm, '012b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def main():
    # Burada add, sw ve lw komutların da listede mevcut
    with open("codes.txt") as cf:
        lines = [l.strip() for l in cf if l.strip()]
    
    with open("instructions.txt", "w") as f:
        for line in lines:
            # Virgülleri temizleyip boşluklara göre ayırıyoruz
            parts = line.replace(',', '').split()
            cmd = parts[0]
            args = parts[1:]
            
            if ((cmd == "addi") or (cmd == "ekleh")): bin_code = assemble_addi(args)
            elif ((cmd == "add") or (cmd == "ekle")): bin_code = assemble_add(args)
            elif ((cmd == "subi") or (cmd == "çıkarh")): bin_code = assemble_subi(args)
            elif ((cmd == "sub") or (cmd == "çıkar")): bin_code = assemble_sub(args)
            elif ((cmd == "sw") or (cmd == "kaydet")): bin_code = assemble_sw(args)
            elif ((cmd == "lw") or (cmd == "oku")): bin_code = assemble_lw(args)
            else:
                print(f"Bilinmeyen komut: {cmd}")
                continue
                
            # Binary string'i tam sayıya çevir (base 2), sonra 8 haneli büyük harfli Hex'e dönüştür
            hex_code = format(int(bin_code, 2), '08X') 
            
            f.write(hex_code + "\n")
            print(f"{line.ljust(20)} -> 0x{hex_code}")

if __name__ == "__main__":
    main()