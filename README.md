A single-cycle RISC-V processor implementing the RV32I base integer instruction set, written in SystemVerilog and simulated with [Verilator](https://www.veripool.org/verilator/) + CMake. The project also includes a Python assembler that translates programs into machine code (hex). Alongside standard RISC-V mnemonics, the assembler accepts a full set of custom Turkish instruction names.

## Features

- Single-cycle datapath
- Full RV32I base instruction set:
  - R-type arithmetic/logic (`add`, `sub`, `sll`, `slt`, `sltu`, `xor`, `srl`, `sra`, `or`, `and`)
  - I-type arithmetic/logic (`addi`, `slti`, `sltiu`, `xori`, `ori`, `andi`, `srli`, `srai`)
  - Memory access (`lw`, `sw`)
  - Branches (`beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`)
  - Jumps (`jal`, `jalr`)
  - Upper immediates (`lui`, `auipc`)
  - Common pseudo-instructions (`nop`, `mv`, `not`, `neg`, `ret`, `j`)
- No OS-facing instructions (`ecall`, `ebreak`, `fence`) — the processor is bare-metal and does not communicate with an environment/kernel
- Programs can be written using Turkish instruction names, standard RISC-V names, or a mix of both
- Python-based assembler (source → hex)
- Register and data memory contents dumped to file at the end of simulation

## Instruction Guide

The assembler accepts both the standard RISC-V names and their Turkish equivalents. Both produce the same machine code.

| Turkish | RISC-V | Type | Syntax | Description |
| :--- | :--- | :--- | :--- | :--- |
| yok | nop | Pseudo (I-Type) | `yok` | `x0 = x0 + 0` (no-operation) |
| ekle | add | R-Type | `ekle x1, x0, x2` | `rd = rs1 + rs2` |
| çıkar | sub | R-Type | `çıkar x1, x0, x2` | `rd = rs1 - rs2` |
| ve | and | R-Type | `ve x1, x0, x2` | `rd = rs1 & rs2` |
| veya | or | R-Type | `veya x1, x0, x2` | `rd = rs1 \| rs2` |
| xveya | xor | R-Type | `xveya x1, x0, x2` | `rd = rs1 ^ rs2` |
| sol | sll | R-Type | `sol x1, x0, x2` | `rd = rs1 << rs2` |
| küçükse | slt | R-Type | `küçükse x1, x0, x2` | `rd = (rs1 < rs2) ? 1 : 0` |
| küçüksei | sltu | R-Type | `küçüksei x1, x0, x2` | `rd = (rs1 < rs2 unsigned) ? 1 : 0` |
| sağ | srl | R-Type | `sağ x1, x0, x2` | `rd = rs1 >> rs2` (logical) |
| sağa | sra | R-Type | `sağa x1, x0, x2` | `rd = rs1 >> rs2` (arithmetic) |
| ters | neg | Pseudo (R-Type) | `ters x1, x0` | `rd = 0 - rs` (two's complement negation) |
| ekleh | addi | I-Type | `ekleh x1, x0, imm` | `rd = rs1 + imm` |
| veyah | ori | I-Type | `veya x1, x0, imm` | `rd = rs1 \| imm` |
| veh | andi | I-Type | `ve x1, x0, imm` | `rd = rs1 & imm` |
| xveyah | xori | I-Type | `xveya x1, x0, imm` | `rd = rs1 ^ imm` |
| küçükseh | slti | I-Type | `küçükseh x1, x0, imm` | `rd = (rs1 < imm) ? 1 : 0` |
| küçüksehi | sltiu | I-Type | `küçüksehi x1, x0, imm` | `rd = (rs1 < imm unsigned) ? 1 : 0` |
| sağh | srli | I-Type (Shift) | `sağh x1, x0, shamt` | `rd = rs1 >> shamt` (logical) |
| sağah | srai | I-Type (Shift) | `sağah x1, x0, shamt` | `rd = rs1 >> shamt` (arithmetic) |
| taşı | mv | Pseudo (I-Type) | `taşı x1, x0` | `rd = rs + 0` |
| değil | not | Pseudo (I-Type) | `değil x1, x0` | `rd = rs ^ -1` (bitwise NOT) |
| dön | ret | Pseudo (I-Type) | `dön` | `pc = x1` (return from function) |
| oku | lw | I-Type (Load) | `oku x1, imm(x0)` | `rd = mem[rs1 + imm]` |
| kaydet | sw | S-Type | `kaydet x2, imm(x0)` | `mem[rs1 + imm] = rs2` |
| eşit | beq | B-Type | `eşit x0, x2, offset` | `if (rs1 == rs2) pc += offset` |
| eşitd | bne | B-Type | `eşitd x0, x2, offset` | `if (rs1 != rs2) pc += offset` |
| küçük | blt | B-Type | `küçük x0, x2, offset` | `if (rs1 < rs2) pc += offset` |
| büyük | bge | B-Type | `büyük x0, x2, offset` | `if (rs1 >= rs2) pc += offset` |
| küçüki | bltu | B-Type | `küçüki x0, x2, offset` | `if (rs1 < rs2 unsigned) pc += offset` |
| büyüki | bgeu | B-Type | `büyüki x0, x2, offset` | `if (rs1 >= rs2 unsigned) pc += offset` |
| atla | j | Pseudo (J-Type) | `atla offset` | `x0 = pc + 4; pc = pc + offset` |
| atlab | jal | J-Type / Pseudo | `atlab x1, offset` | `rd = pc + 4; pc = pc + offset` |
| atlas | jalr | I-Type / Pseudo | `atlas x1, 0(x0)` | `rd = pc + 4; pc = rs` |
| yüksekh | lui | U-Type | `yüksekh x1, imm` | `rd = imm << 12` |
| yüksekpc | auipc | U-Type | `yüksekpc x1, imm` | `rd = pc + (imm << 12)` |

Registers are written as `x0`–`x31`. For memory instructions, the offset uses the `imm(rsN)` form; for example, `1(x3)`. Immediates may be given in decimal or hex (`0x...`).

### Example Program

```
ekleh x1, x0, 3           # x1 = 3
ekleh x2, x0, 5           # x2 = 5
ekle  x3, x1, x2          # x3 = x1 + x2 = 8
çıkar x4, x2, x1          # x4 = x2 - x1 = 2
eşitd x1, x2, 8           # x1 != x2, branch taken -> pc += 8, skips the next instruction
ekleh x8, x0, 99          # skipped
kaydet x3, 0(x0)          # mem[0] = x3
oku    x5, 0(x0)          # x5 = mem[0]
yüksekh x6, 0x12345       # x6 = 0x12345000
yüksekpc x7, 0x2          # x7 = pc + 0x2000
atla  8                   # unconditional jump, pc += 8, skips the next instruction
ekleh x9, x0, 111         # skipped
ekleh x10, x0, 1          # x10 = 1
```

## How to Run

### Requirements

- Verilator
- CMake (3.12+)
- Python 3
- A C++14-capable compiler

### 1. Write Your Program

Write the instructions you want to run into `codes.txt`, one instruction per line.

### 2. Build

Run these from the project root. The `-S` flag points CMake at the `cmake_psc` directory, where `CMakeLists.txt` lives:

```bash
cmake -S cmake_psc -B build
cmake --build build
```

Whenever `codes.txt` changes, the assembler runs automatically during the build and regenerates `instructions.txt` (the hex machine code read by the processor).

### 3. Run the Simulation

The simulation must be run from the main directory so that `$readmem` can locate `instructions.txt`:

```bash
build/example
```

## Outputs

- `instructions.txt` — Hex machine code produced by the assembler; read by the processor.
- `data_memory.txt` — At the end of simulation, the final contents of data memory (`data[0:31]`) are written to this file.
- The final register values are printed to the terminal when the simulation ends.

## Project Structure

```
.processor_single_cycle/
├── .vscode/
│   └── settings.json
└── cmake_psc/
│   └── CMakeLists.txt      # Build script
├── make_psc/
│   ├── ALU.sv
│   ├── branch.sv
│   ├── control.sv          # Control unit (instruction decoding)
│   ├── data_memory.sv      # Data memory
│   ├── extender.sv
│   ├── instruction_memory.sv
│   ├── Makefile
│   ├── prog_cnt.sv
│   ├── register.sv
│   ├── riscv_pkg.sv
│   ├── sim_main.cpp        # Verilator simulation entry point
│   └── top.sv              # Processor top module
├── assembler.py            # Assembler that converts source into hex machine code
├── codes.txt               # Your program (assembler input)
├── data_memory.txt
├── dump.vcd
└── instructions.txt        # Generated hex machine code (assembler output)
```