`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024
// Design Name: 
// Module Name: 
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


module ExecutionMemory_tb();
                    //reg = input wire = output;
                    /*Clk, pc_in, Zero_in, pc_in_2, ALUResult_in, read_data_2_in, WriteRegister_in, // datapath inputs
                        pc_out, Zero_out, pc_out_2, ALUResult_out, read_data_2_out, WriteRegister_out, // datapath outputs

                     AndValue_in, MemtoReg_in, RegWrite_in, RegWriteSrc_in, // writeback control inputs
                     AndValue_out, MemtoReg_out, RegWrite_out, RegWriteSrc_out,// writeback control outputs

                     Branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in, //memory control inputs
                     Branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out);//memory control inputs*/
    reg Clk;

    //datapath information
    reg [31:0] pc_in, pc_in_2, ALUResult_in, read_data_1_in, read_data_2_in;
    reg[4:0] WriteRegister_in;
    reg Zero_in; // only 1 bit datapath signal

    wire [31:0] pc_out, pc_out_2, ALUResult_out, read_data_1_out, read_data_2_out;
    wire [4:0] WriteRegister_out;
    wire Zero_out;

    //writeback control signals
    reg [31:0] AndValue_in; //32 bit signal
    reg [1:0] MemtoReg_in; //2 bit control signals
    reg RegWrite_in, RegWriteSrc_in; //1 bit control signals

    wire [31:0] AndValue_out; //32 bit signal
    wire [1:0] MemtoReg_out; //2 bit control signals
    wire RegWrite_out, RegWriteSrc_out; //1 bit control signals

    //memory control signals
    reg Branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in;
    wire Branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out;

    ExecutionMemory u0(Clk, pc_in, Zero_in, pc_in_2, ALUResult_in, read_data_1_in, read_data_2_in, WriteRegister_in, // datapath inputs
                        pc_out, Zero_out, pc_out_2, ALUResult_out, read_data_1_out, read_data_2_out, WriteRegister_out, // datapath outputs

                     AndValue_in, MemtoReg_in, RegWrite_in, RegWriteSrc_in, // writeback control inputs
                     AndValue_out, MemtoReg_out, RegWrite_out, RegWriteSrc_out,// writeback control outputs

                     Branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in, //memory control inputs
                     Branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out);//memory control inputs   
                    
initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
    end

initial begin
    #5;
    //datapath
    pc_in <= 32'd32;
    pc_in_2 <= 32'd32;
    ALUResult_in <= 32'd32; 
    read_data_1_in  <= 32'd32;
    read_data_2_in  <= 32'd32;
    WriteRegister_in <= 5'd5;
    Zero_in = 0;

    //writeback
    AndValue_in <= 32'd32;
    MemtoReg_in <= 2'd2;
    RegWrite_in <= 0;
    RegWriteSrc_in <= 0;

    //memory control
    Branch_in <= 0;
    MemRead_in <= 0; 
    MemWrite_in <= 0; 
    Unconditional_in <= 0;
    BranchNE_in <= 0; 
    MemWriteSrc_in <= 0;



end
        
endmodule