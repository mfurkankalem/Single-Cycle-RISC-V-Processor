# assembler.py
import sys
import os
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

def parse_mem_arg(arg):
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

def assemble_rtype(args, funct3, funct7):
    rd = int(args[0].replace('x', ''))
    rs1 = int(args[1].replace('x', ''))
    rs2 = int(args[2].replace('x', ''))
    opcode = "0110011"
    return f"{funct7}{format(rs2, '05b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def assemble_jal(args):
    rd = int(args[0].replace('x', ''))
    imm = int(args[1])
    if imm % 2 != 0:
        raise ValueError(f"jal offset must be even: {imm}")
    if imm < 0: imm = (1 << 21) + imm
    # b[0] holds imm[20], b[20] holds imm[0]
    b = format(imm, '021b')
    opcode = "1101111"
    return f"{b[0]}{b[10:20]}{b[9]}{b[1:9]}{format(rd, '05b')}{opcode}"

def assemble_jalr(args):
    rd = int(args[0].replace('x', ''))
    imm, rs1 = parse_mem_arg(args[1])
    if imm < 0: imm = (1 << 12) + imm
    opcode = "1100111"
    funct3 = "000"
    return f"{format(imm, '012b')}{format(rs1, '05b')}{funct3}{format(rd, '05b')}{opcode}"

def main():
    with open(os.path.join(SCRIPT_DIR, "codes.txt")) as cf:
        lines = [l.strip() for l in cf if l.strip()]

    with open(os.path.join(SCRIPT_DIR, "instructions.txt"), "w") as f:
        for line in lines:
            parts = line.replace(',', '').split()
            cmd = parts[0]
            args = parts[1:]

            if ((cmd == "addi") or (cmd == "ekleh")): bin_code = assemble_addi(args)
            elif ((cmd == "add") or (cmd == "ekle")): bin_code = assemble_add(args)
            elif ((cmd == "sub") or (cmd == "çıkar")): bin_code = assemble_rtype(args, "000", "0100000")
            elif ((cmd == "sw") or (cmd == "kaydet")): bin_code = assemble_sw(args)
            elif ((cmd == "lw") or (cmd == "oku")): bin_code = assemble_lw(args)
            elif ((cmd == "sll") or (cmd == "ksm")): bin_code = assemble_rtype(args, "001", "0000000")
            elif ((cmd == "srl") or (cmd == "kgm")): bin_code = assemble_rtype(args, "101", "0000000")
            elif ((cmd == "sra") or (cmd == "kga")): bin_code = assemble_rtype(args, "101", "0100000")
            elif ((cmd == "slt") or (cmd == "ka")): bin_code = assemble_rtype(args, "010", "0000000")
            elif ((cmd == "sltu") or (cmd == "kai")): bin_code = assemble_rtype(args, "011", "0000000")
            elif ((cmd == "jal") or (cmd == "atlavb")): bin_code = assemble_jal(args)
            elif ((cmd == "jalr") or (cmd == "atlavs")): bin_code = assemble_jalr(args)
            else:
                print(f"Bilinmeyen komut: {cmd}")
                continue


            hex_code = format(int(bin_code, 2), '08X')
            f.write(hex_code + "\n")
            print(f"{line.ljust(20)} -> 0x{hex_code}")

if __name__ == "__main__":
    main()