`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
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


module MemoryWriteback_tb();

                            Clk, MemtoReg_in, RegWrite_in, AndValue_in, RegWriteSrc_in, pc_in, MemData_in, AluResult_in, WriteRegister_in, read_data_1_in, read_data_2_in,
                            MemtoReg_out, RegWrite_out, AndValue_out, RegWriteSrc_out, pc_out, MemData_out, AluResult_out, WriteRegister_out, read_data_1_out, read_data_2_out);
    //clk
    reg Clk;

    //datapath information
    reg [31:0] pc_in, MemData_in, AluResult_in, read_data_1_in, read_data_2_in;
    reg [4:0] WriteRegister_in;
    //control signals
    reg [31:0] AndValue_in; //32 bit signal
    reg [1:0] MemtoReg_in; //2 bit control signals
    reg RegWrite_in, RegWriteSrc_in; //1 bit control signals

    //datapath information
    wire [31:0] pc_out, MemData_out, AluResult_out, read_data_1_out, read_data_2_out;
    wire [4:0] WriteRegister_out;
    //control signals
    wire [31:0] AndValue_out;  //32 bit signal
    wire [1:0] MemtoReg_out; //2 bit control signals
    wire RegWrite_out, RegWriteSrc_out; //1 bit control signals

    MemoryWriteback u0(Clk, MemtoReg_in, RegWrite_in, AndValue_in, RegWriteSrc_in, pc_in, MemData_in, AluResult_in, WriteRegister_in, read_data_1_in, read_data_2_in,
                            MemtoReg_out, RegWrite_out, AndValue_out, RegWriteSrc_out, pc_out, MemData_out, AluResult_out, WriteRegister_out, read_data_1_out, read_data_2_out);


initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
    end

initial begin
    #5;
    
        //datapath information
        pc_in <= 32'd32;
        MemData_out <= 32'd32;
        AluResult_out <= 32'd32;
        read_data_1_out <= 32'd32;
        read_data_2_out <= 32'd32;
        WriteRegister_out <= 5'd5;
        //control signals
        AndValue_in <= 32'd32;
        MemtoReg_in <= 2'd2;
        RegWrite_in <= 0;
        RegWriteSrc_in <= 0;
        end
        
endmodule
