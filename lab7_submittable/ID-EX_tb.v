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


module DecodeExecute_tb();

    reg Clk;

    // regs
    reg [31:0] read_data_1_in, read_data_2_in, sa_in, imm_in, target_in, pc_in;
    reg [4:0] rt_in, rd_in; 
   
    // execution control inputs
    reg [1:0] ALUSrc_in, RegDst_in;
    reg [3:0] ALUop_in;
    reg ShiftSrc_in, RegJump_in;

    // memory control inputs
    reg branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in;

    // write back control inputs
    reg [1:0] MemToReg_in;
    reg [31:0] AndValue_in;
    reg RegWrite_in, RegWriteSrc_in;

    //outputs
    wire [31:0] read_data_1_out, read_data_2_out, sa_out, imm_out, target_out, pc_out;
    wire [4:0] rt_out, rd_out;

    // execution control outputs
    wire [1:0] ALUSrc_out, RegDst_out;
    wire [3:0] ALUop_out;
    wire ShiftSrc_out, RegJump_out;

    // memory control outputs
    wire branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out;

    // write back control outputs
    wire [1:0] MemToReg_out;
    wire [31:0] AndValue_out;
    wire RegWrite_out, RegWriteSrc_out;

    DecodeExecute u1(Clk, read_data_1_in, read_data_2_in, sa_in, imm_in, rt_in, rd_in, target_in, pc_in, // inputs
                     ALUSrc_in, ALUop_in, ShiftSrc_in, RegJump_in, RegDst_in, // execution control inputs
                     branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in,  // memory control inputs
                     MemToReg_in, RegWrite_in, AndValue_in, RegWriteSrc_in, // write back control inputs

                     read_data_1_out, read_data_2_out, sa_out, imm_out, rt_out, rd_out, target_out, pc_out, // outputs
                     ALUSrc_out, ALUop_out, ShiftSrc_out, RegJump_out, RegDst_out, // execution control outputs
                     branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out,  // memory control outputs
                     MemToReg_out, RegWrite_out, AndValue_out, RegWriteSrc_out // write back control outputs
                    ); 
    

    initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
    end

    initial begin
        #5;
        read_data_1_in <= 32'd32;
        read_data_2_in <= 32'd32;
        sa_in <= 32'd32;
        imm_in <= 32'd32;
        rt_in <= 5'd5;
        rd_in <= 5'd5;
        target_in <= 32'd32;
        pc_in <= 32'd32;

        // execution control
        ALUSrc_in <= 2'd2;
        ALUop_in <= 4'd4;
        ShiftSrc_in <= 1'd1;
        RegJump_in <= 1'd1;
        RegDst_in <= 2'd2;

        // memory control 
        branch_in <= 0;
        MemRead_in <= 0; 
        MemWrite_in <= 0; 
        Unconditional_in <= 0;
        BranchNE_in <= 0; 
        MemWriteSrc_in <= 0;
        
        // write back control 
        AndValue_in <= 32'd32;
        MemToReg_in <= 2'd2;
        RegWrite_in <= 0;
        RegWriteSrc_in <= 0;

    end
        
endmodule
