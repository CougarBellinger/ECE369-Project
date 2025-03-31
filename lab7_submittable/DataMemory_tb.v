`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever begin 
            #10 Clk <= ~Clk;

            $write("Address:  %h, WriteData: %h\n", Address, WriteData);
            $write("MemWrite: %b, MemRead :  %b\n", MemWrite, MemRead);
            $write("ReadData: %h\n\n", ReadData);
        end
	end

	initial begin
        
        //begin with 5ns offset
        #5; MemWrite = 'h0; MemRead = 'h0;

        //Test cases for address = 4 (2nd word) with write data = 1
        Address = 'h4; WriteData = 'h1;
        
        #20; MemWrite = 'h1; MemRead = 'h0;
        #20; MemWrite = 'h0; MemRead = 'h1;
        #20; MemWrite = 'h1; MemRead = 'h1;

        #20; MemWrite = 'h0; MemRead = 'h0;

        //Test cases for address = 4092 (1023rd word) and write data = 'hFFFFFFFF
        Address = 'hFFC; WriteData   = 'hFFFFFFFF;

        #20; MemWrite = 'h1; MemRead = 'h0;
        #20; MemWrite = 'h0; MemRead = 'h1;
        #20; MemWrite = 'h1; MemRead = 'h1;

        #20; MemWrite = 'h0; MemRead = 'h0;
        
        $stop;
	end

endmodule

