`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Overall percent effort of each team member: 
// Cougar: 100%
// Eden: 100%
// Jake: 100%

//Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 03:56:31 PM
// Design Name: 
// Module Name: SingleCycle
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


module SingleCycle(Clk, IF_PC, WB_WriteData, PCValue, WriteRegisterValue, PCsrc, WB_WriteRegister,  WB_RegWriteSrc, WB_MemData, WB_MemToReg,
                                zero, MEM_BranchNE, MEM_PCJump, MEM_MemWrite, MEM_MemRead, MEM_Zero, muxMemToReg, muxMemWriteSrc, 
                                EX_sa, 
                                IF_Address, IF_PCadd,
                                ID_Instruction, ID_readData1, ID_readData2, ALUresult, Reset
                               );

    output wire [31:0] PCValue, WriteRegisterValue;                          
    (* mark_debug = "true"*) output wire [31:0] IF_PC; 
    (* mark_debug = "true"*) output wire [31:0] WB_WriteData;
    
    assign PCValue = IF_PC - 32'd12; // adjust PC value to be the same as instruction
    assign WriteRegisterValue = WB_WriteData;
    
    input Clk, Reset;
    //Writeback wires
    
    output wire [4:0] WB_WriteRegister;
    wire WB_RegWrite;

    //Memory wires
    output wire [31:0] MEM_PCJump;
    output wire PCsrc;

    // ==================================================================================================================================================================================================
    // IF
    // ==================================================================================================================================================================================================
    
    output wire [31:0] IF_PCadd;

    output wire [31:0] IF_Address;
    Mux32Bit2To1 Mux_PCSrc(
        .sel (PCsrc),

        .inA (IF_PCadd),
        .inB (MEM_PCJump),

        .out (IF_Address)
    );
    
    PCAdder PCadd(
        .PCResult (IF_PC),
        .PCAddResult (IF_PCadd)
    );

    ProgramCounter PC(
        .Clk (Clk),
        .Reset(Reset), //????
        //input
        .Address (IF_Address),
        //output
        .PCResult (IF_PC)
    );

    
    wire [31:0] IF_Instruction;
    InstructionMemory InstructionMem(
        .Address (IF_PC),
        .Instruction (IF_Instruction)
    );


    // ==================================================================================================================================================================================================
    // IF
    wire [31:0] ID_PC;
    output wire [31:0] ID_Instruction;
    FetchDecode IFtoID( 
        .Clk (Clk),
        .Reset (Reset),

        .instruction_in (IF_Instruction),
        .pc_in (IF_PCadd),

        .instruction_out (ID_Instruction),
        .pc_out(ID_PC)
    );
    // ID
    // ==================================================================================================================================================================================================


    // Control wires divided by phase
    //--------------------------------

    //EX
    wire ID_ALUASrc;
    wire [1:0] ID_ALUSrc, ID_RegDst, ID_RegJump;
    wire [3:0] ID_ALUop;
    //MEM
    wire ID_Branch, ID_BranchNE, ID_MemWrite, ID_MemRead, ID_MemWriteSrc, ID_Unconditional;
    //BOTH MEM and WB
    wire [31:0] ID_AndValue;
    //WB
    wire ID_RegWrite, ID_RegWriteSrc;
    wire [1:0] ID_MemtoReg;

    SingleCycleController Controller(
        //OpCode input
        .instruction (ID_Instruction),
        //Output Signals
        .ALUSrc2 (ID_ALUASrc),
        .ALUSrc (ID_ALUSrc),
        .ALUop (ID_ALUop),
        .JumpSrc (ID_RegJump),
        .RegDst (ID_RegDst),
        .Branch (ID_Branch),
        .MemRead (ID_MemRead),
        .MemWrite (ID_MemWrite),
        .Unconditional (ID_Unconditional),
        .BranchNE (ID_BranchNE),
        .MemWriteSrc (ID_MemWriteSrc),
        .MemtoReg (ID_MemtoReg),
        .RegWrite (ID_RegWrite),
        .AndValue (ID_AndValue),
        .RegWriteSrc (ID_RegWriteSrc)
    );

    //Registers Block
    output wire [31:0] ID_readData1, ID_readData2;
    RegisterFile Registers(
        //inputs
        .ReadRegister1 (ID_Instruction[25:21]), // rt
        .ReadRegister2 (ID_Instruction[20:16]), // rs
        .WriteRegister (WB_WriteRegister),      // from WB stage
        .WriteData (WB_WriteData),              // from WB stage
        .RegWrite (WB_RegWrite),                // from WB stage
        .Clk (Clk),

        //outputs
        .ReadData1 (ID_readData1),
        .ReadData2 (ID_readData2)
    );

    //SignExtension 16 bit --> 32 bit
    wire [31:0] ID_immed32;
    SignExtension16bit SignExtend32(
        .in (ID_Instruction[15:0]),
        .out(ID_immed32)
    );

    //26 bit target --> 32 bit
    wire [31:0] ID_target32;
    assign ID_target32 = {ID_PC[31:28], ID_Instruction[25:0], 2'b00};


    // ==================================================================================================================================================================================================
    // ID
    wire [31:0] EX_readData1, EX_readData2, EX_immed32, EX_target, EX_PC;
    wire [31:0] EX_AndValue;
    wire [4:0] EX_rt, EX_rd;
    output wire [31:0] EX_sa;
    wire [3:0] EX_ALUop;
    wire [1:0] EX_ALUsrc, EX_RegDst, EX_MemToReg, EX_RegJump;
    wire EX_ALUASrc;
    wire EX_Branch, EX_MemRead, EX_MemWrite, EX_Unconditional, EX_BranchNE, EX_MemWriteSrc;
    wire EX_RegWrite, EX_RegWriteSrc;

    DecodeExecute IDtoEX(
        .Clk (Clk),
        .Reset (Reset),
        // inputs----------------------------------
        .read_data_1_in (ID_readData1), .read_data_2_in (ID_readData2), .sa_in ({27'b0,ID_Instruction[10:6]}), .imm_in (ID_immed32),
        .rt_in (ID_Instruction[20:16]), .rd_in (ID_Instruction[15:11]), .target_in (ID_target32), .pc_in (ID_PC),

        // execution control inputs
        .ALUSrc_in (ID_ALUSrc), .ALUASrc_in(ID_ALUASrc), .ALUop_in(ID_ALUop), .RegJump_in (ID_RegJump), .RegDst_in (ID_RegDst),

        // memory control inputs
        .branch_in (ID_Branch), .MemRead_in(ID_MemRead), .MemWrite_in(ID_MemWrite), .Unconditional_in(ID_Unconditional),
        .BranchNE_in(ID_BranchNE), .MemWriteSrc_in (ID_MemWriteSrc),

        // write back control inputs
        .MemToReg_in (ID_MemtoReg), .RegWrite_in (ID_RegWrite), .AndValue_in (ID_AndValue), .RegWriteSrc_in (ID_RegWriteSrc),


        // outputs----------------------------------
        .ALUASrc_out(EX_ALUASrc), .read_data_1_out (EX_readData1), .read_data_2_out (EX_readData2), .sa_out (EX_sa), .imm_out (EX_immed32),
        .rt_out(EX_rt), .rd_out (EX_rd), .target_out (EX_target), .pc_out (EX_PC),

        // execution control outputs
        .ALUSrc_out (EX_ALUsrc), .ALUop_out (EX_ALUop), .RegJump_out (EX_RegJump), .RegDst_out (EX_RegDst),

        // memory control outputs
        .branch_out (EX_Branch), .MemRead_out (EX_MemRead), .MemWrite_out (EX_MemWrite), .Unconditional_out (EX_Unconditional),
        .BranchNE_out (EX_BranchNE), .MemWriteSrc_out (EX_MemWriteSrc),

        // write back control outputs
        .MemToReg_out (EX_MemToReg), .RegWrite_out (EX_RegWrite), .AndValue_out (EX_AndValue), .RegWriteSrc_out (EX_RegWriteSrc)
    );
    // EX
    // ==================================================================================================================================================================================================

    // JUMPS ------------------------------------------------

    // Shift to be word compatible
    wire [31:0] shiftImmediate;
    assign shiftImmediate = EX_immed32 << 2;

    // Add jump address to PC
    wire [31:0] addJump;
    assign addJump = EX_PC + shiftImmediate;

    wire [31:0] muxRegJump;
    
    //checked wires and they all have been declared
    Mux32Bit4To1 Mux_RegJump(
        .sel (EX_RegJump),
        
        .inA (addJump), // Output from AddJump
        .inB (EX_readData1), //for jr
        .inC (EX_target), //for j and jal
        .inD (0), // From ID/EX Register

        .out (muxRegJump) // To EX/MEM Register
    );
    

    // ALU ------------------------------------------------
    //Mux for ALU input A
    wire [31:0] muxALUASrc;
    
    Mux32Bit2To1 Mux_ALUASrc(
        .sel (EX_ALUASrc),

        .inA(EX_readData1),
        .inB(EX_readData2),

        .out(muxALUASrc)
    );
    //Mux for ALU input B
    wire [31:0] muxAluSrc;
    Mux32Bit4To1 Mux_AluSrc(
        .sel (EX_ALUsrc),

        .inA (EX_readData2),
        .inB (EX_immed32),
        .inC (0),
        .inD (EX_sa),

        .out (muxAluSrc)
    );

    // ALU
    output wire [63:0] ALUresult;
    output wire zero;
    ALU32Bit ALU(
        .ALUControl (EX_ALUop),

        //inputs
        .A (muxALUASrc),
        .B (muxAluSrc),

        //output
        .ALUResult (ALUresult),
        .Zero (zero)
    );

    // WRITE REGISTER ------------------------------------------
    wire [4:0] muxRegDst;
    Mux5Bit4To1 Mux_RegDst(
        .sel (EX_RegDst), //RegDst Signal

        .inA (EX_rt), // Instr rt
        .inB (EX_rd), // Instr rd
        .inC (5'd31),
        .inD (5'b0), // Not needed

        .out (muxRegDst)
    );

    // ==================================================================================================================================================================================================
    // EX

    //datapath wires
    wire [31:0] MEM_readData2, MEM_PC, MEM_ALUresult;
    wire [4:0] MEM_WriteReg;
    output wire MEM_Zero;

    //writeback control wires
    wire [31:0] MEM_AndValue;
    wire [1:0] MEM_MemToReg;
    wire MEM_RegWrite, MEM_RegWriteSrc;

    //memory control wires
    wire MEM_Branch, MEM_Unconditional, MEM_WriteSrc;
    output wire MEM_MemRead, MEM_MemWrite, MEM_BranchNE;

    ExecutionMemory EXtoMEM(
        .Clk (Clk),
        .Reset (Reset),
        // datapath inputs
        .pc_in (muxRegJump), .Zero_in (zero), .pc_in_2 (EX_PC), .ALUResult_in (ALUresult[31:0]),
        .read_data_2_in (EX_readData2), .WriteRegister_in (muxRegDst),
        // datapath outputs
        .pc_out (MEM_PCJump), .Zero_out (MEM_Zero), .pc_out_2 (MEM_PC), .ALUResult_out (MEM_ALUresult),
        .read_data_2_out (MEM_readData2), .WriteRegister_out (MEM_WriteReg),

        // writeback control inputs
        .AndValue_in (EX_AndValue), .MemtoReg_in (EX_MemToReg), .RegWrite_in (EX_RegWrite), .RegWriteSrc_in (EX_RegWriteSrc),
        //writeback control outputs
        .AndValue_out (MEM_AndValue), .MemtoReg_out (MEM_MemToReg), .RegWrite_out (MEM_RegWrite), .RegWriteSrc_out (MEM_RegWriteSrc),

        //memory control inputs
        .Branch_in (EX_Branch), .MemRead_in (EX_MemRead), .MemWrite_in (EX_MemWrite), .Unconditional_in (EX_Unconditional),
        .BranchNE_in (EX_BranchNE), .MemWriteSrc_in (EX_MemWriteSrc),
        //memory control outputs
        .Branch_out (MEM_Branch), .MemRead_out (MEM_MemRead), .MemWrite_out (MEM_MemWrite), .Unconditional_out (MEM_Unconditional),
        .BranchNE_out (MEM_BranchNE), .MemWriteSrc_out (MEM_WriteSrc)
    );
    // MEM
    // ==================================================================================================================================================================================================

    // BRANCHING ------------------------------------------------
    wire muxNotEqual;

    assign muxNotEqual = MEM_BranchNE ? ~MEM_Zero : MEM_Zero; //if MembranchNE = 0 MEM_Zero is sent and gate with memBranch

    // wires for branching logic
    wire andBranch;
    assign andBranch = MEM_Branch & muxNotEqual;
    assign PCsrc = MEM_Unconditional | andBranch; //declared on top of file

    // DATA MEMORY ------------------------------------------------
    // wire for lh & lb instructions
    wire [31:0] andFilter;
    assign andFilter = MEM_readData2 & MEM_AndValue;

    // mux for write src
    output wire [31:0] muxMemWriteSrc;
    Mux32Bit2To1 Mux_MemWriteSrc(
        .sel(MEM_WriteSrc), //MemWriteSrc

        .inA(MEM_readData2), //ReadData2
        .inB(andFilter), //andFilter

        .out(muxMemWriteSrc) 
    );

    wire [31:0] readDataMem;
    DataMemory DataMemory(
        .Address (MEM_ALUresult), //ALU Result
        .WriteData (muxMemWriteSrc),
        .Clk (Clk),
        .MemWrite (MEM_MemWrite),
        .MemRead (MEM_MemRead),
        .ReadData(readDataMem)
    );

    wire [31:0] iterate_PC;
    assign iterate_PC = MEM_PC + 4; //may need to remove

    // ==================================================================================================================================================================================================
    // MEM

    wire [31:0] WB_AndValue, WB_PCout, WB_ALUResult;
    output wire [31:0] WB_MemData;
    output wire [1:0] WB_MemToReg;
    output wire WB_RegWriteSrc;
    MemoryWriteback MEMtoWB(
        .Clk (Clk),
        .Reset (Reset),
        // Datapath inputs
        .MemData_in (readDataMem), .AluResult_in (MEM_ALUresult), .WriteRegister_in (MEM_WriteReg), .pc_in (iterate_PC),
        // Memory control inputs
        .MemtoReg_in (MEM_MemToReg), .RegWrite_in (MEM_RegWrite), .AndValue_in (MEM_AndValue), .RegWriteSrc_in (MEM_RegWriteSrc), 

        // Memory outputs
        .MemtoReg_out (WB_MemToReg), .RegWrite_out (WB_RegWrite), .AndValue_out (WB_AndValue), .RegWriteSrc_out (WB_RegWriteSrc),
        // Datapath outputs
        .MemData_out (WB_MemData), .AluResult_out (WB_ALUResult), .WriteRegister_out (WB_WriteRegister), .pc_out (WB_PCout)
    );

    // WB
    // ==================================================================================================================================================================================================

    output wire [31:0] muxMemToReg;
    Mux32Bit4To1 Mux_MemToReg(
        .sel(WB_MemToReg),

        .inA(WB_MemData),
        .inB(WB_ALUResult),
        .inC(WB_PCout),
        .inD(0),

        .out(muxMemToReg) 
    );

    wire [31:0] filter;
    assign filter = WB_AndValue & muxMemToReg;
    
    Mux32Bit2To1 Mux_WriteData(
        .sel(WB_RegWriteSrc),

        .inA(muxMemToReg),
        .inB(filter),

        .out(WB_WriteData)
    );


endmodule
