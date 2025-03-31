`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// / Overall percent effort of each team member: 
// Cougar: 100%
// Eden: 100%
// Jake: 101%
// Create Date: 10/27/2024 02:41:42 PM
// Design Name: 
// Module Name: SingleCycle_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SingleCycle_tb();

reg Clk;
reg Reset;
wire [63:0] ALUresult;
wire [31:0] IF_PCadd, IF_Address, jumpAddress, sa32bit, programCounter, writedata_out, Instruction, readData1, readData2, muxMemToReg, memWriteData, memReadData;
wire [4:0] writeRegister;
wire [1:0] MemToReg;
wire RegWriteSrc, MemWrite, MemRead, PCsrc, MEM_Zero, MEM_BranchNE, zeroALU;

SingleCycle u0(
    .MEM_Zero(MEM_Zero),
    .IF_PCadd(IF_PCadd),
    .IF_Address(IF_Address),
    .MEM_PCJump(jumpAddress),
    .MEM_BranchNE(MEM_BranchNE),
    .zero(zeroALU),
    .PCsrc(PCsrc),
    .Reset(Reset),
    .Clk(Clk),
    .IF_PC(programCounter),
    .ID_Instruction(Instruction),
    .ALUresult(ALUresult),
    .ID_readData1(readData1),
    .ID_readData2(readData2),
    .WB_WriteData(writedata_out),
    .WB_WriteRegister(writeRegister),
    .WB_RegWriteSrc(RegWriteSrc),
    .muxMemToReg(muxMemToReg),
    .muxMemWriteSrc(memWriteData),
    .MEM_MemWrite(MemWrite),
    .MEM_MemRead(MemRead),
    .WB_MemData(memReadData),
    .WB_MemToReg(MemToReg),
    .EX_sa(sa32bit)
    );
    
initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
    end

initial begin
    #5;
    Reset = 1;
    #20;
    Reset = 0;
    #20;
end

endmodule
