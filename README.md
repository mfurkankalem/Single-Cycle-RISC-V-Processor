A single-cycle RISC-V processor capable of simple addition, subtraction, store-to-memory, and load-from-memory operations. The design is written in SystemVerilog and simulated with [Verilator](https://www.veripool.org/verilator/) + CMake. The project also includes a Python assembler that translates programs written with custom Turkish instruction names into machine code (hex).

## Features

- Single-cycle datapath
- R-type and I-type instruction support (`add`, `sub`, `addi`, `subi`)
- Memory access (`lw`, `sw`)
- Programs can be written using Turkish instruction names
- Python-based assembler (source → hex)
- Register and data memory contents dumped to file at the end of simulation

## Instruction Guide

The assembler accepts both the standard RISC-V names and their Turkish equivalents. Both produce the same machine code.

| Turkish | RISC-V | Type   | Syntax                   | Description                            |
|---------|--------|--------|--------------------------|----------------------------------------|
| ekle    | add    | R-type | `ekle rd rs1 rs2`        | `rd = rs1 + rs2`                        |
| çıkar   | sub    | R-type | `çıkar rd rs1 rs2`       | `rd = rs1 - rs2`                        |
| ekleh   | addi   | I-type | `ekleh rd rs1 imm`       | `rd = rs1 + imm`                        |
| çıkarh  | subi   | I-type | `çıkarh rd rs1 imm`      | `rd = rs1 - imm`                        |
| kaydet  | sw     | S-type | `kaydet rs2 imm(rs1)`    | `mem[rs1 + imm] = rs2` (store)          |
| oku     | lw     | I-type | `oku rd imm(rs1)`        | `rd = mem[rs1 + imm]` (load)            |

Registers are written as `x0`–`x31`. For memory instructions, the offset uses the `imm(rsN)` form; for example, `1(x3)`.

### Example Program

```
ekleh x1 x0 3        # x1 = 3
ekleh x2 x0 5        # x2 = 5
ekle  x3 x1 x2       # x3 = x1 + x2 = 8
çıkar x4 x2 x1       # x4 = x2 - x1 = 2
kaydet x3 0(x0)      # mem[0] = x3
oku    x5 0(x0)      # x5 = mem[0]
```

## How to Run

### Requirements

- Verilator
- CMake (3.12+)
- Python 3
- A C++14-capable compiler

### 1. Write Your Program

Write the instructions you want to run into `make_psc/codes.txt`, one instruction per line.

### 2. Build

Run these from the project root. The `-S` flag points CMake at the `cmake_psc` directory, where `CMakeLists.txt` lives:

```bash
cmake -S cmake_psc -B build
cmake --build build
```

Whenever `codes.txt` changes, the assembler runs automatically during the build and regenerates `instructions.txt` (the hex machine code read by the processor).

### 3. Run the Simulation

The simulation must be run from the `make_psc` directory so that `$readmem` can locate `instructions.txt`:

```bash
cd make_psc
../build/example
```

## Outputs

- `instructions.txt` — Hex machine code produced by the assembler; read by the processor.
- `data_memory.txt` — At the end of simulation, the final contents of data memory (`data[0:31]`) are written to this file.
- The final register values are printed to the terminal when the simulation ends.

## Project Structure

```
.
├── make_psc/
│   ├── assembler.py        # Assembler that converts source into hex machine code
│   ├── codes.txt           # Your program (assembler input)
│   ├── instructions.txt    # Generated hex machine code (assembler output)
│   ├── top.sv              # Processor top module
│   ├── control.sv          # Control unit (instruction decoding)
│   ├── data_memory.sv      # Data memory
│   └── sim_main.cpp        # Verilator simulation entry point
└── cmake_psc/
    └── CMakeLists.txt      # Build script
```