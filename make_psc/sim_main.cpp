#include <verilated.h>      
#include <verilated_vcd_c.h>

// Include model header, generated from Verilating "top.v"
#include "Vtop.h"

int main(int argc, char** argv) {
 
    VerilatedContext* const contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    contextp->traceEverOn(true);        
    Vtop* const top = new Vtop{contextp};
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("/home/mfurk/Belgeler/RISC-V/SystemVerilog/processor_single_cycle/dump.vcd");
    
    while (!contextp->gotFinish() && contextp->time() < 16) {
        contextp->timeInc(1);
        top->clk = !top->clk;
        top->eval();
        tfp->dump(contextp->time());
    }
    
    tfp->close();
    top->final();
    
    delete top;  
    return 0;  
}
