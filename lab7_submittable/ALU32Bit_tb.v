`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [63:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
        /* Please fill in the implementation here... */
        
        //add
        A = 2;
        B = 2;
        ALUControl = 4'b0000;//: ALUResult = A + B;  // add, addi
        #10

        //sub
        A = 4;
        B = 2;
        ALUControl = 4'b0010; // : ALUResult = A - B;  // sub
        #10
        
        //sub for zero testing
        A = 8;
        B = 8;
        ALUControl = 2'b10;
        #10

        //mul : ALUResult = A * B;  // mul
        A = 'h80000000;
        B = 'h80000000;
        ALUControl = 4'b0011;
        #10;

        //: ALUResult = A & B;  // and, andi
        A = 2;
        B = 2;
        ALUControl = 4'b0100; 
        #10;


        A = 1;
        B = 2;
        ALUControl = 4'b0101;//: ALUResult = A | B; // or, ori
        #10;

        A = 1;
        B = 2;
        ALUControl = 4'b0110;//: ALUResult = ~(A | B); // nor
        #10;

        A = 1;
        B = 2;
        ALUControl = 4'b0111;//: ALUResult = ~(A | B); // xor, xori
        #10;

        A = 1;
        B = 2;
        ALUControl = 4'b1000;//: ALUResult = A << B; // sll
        #10;

        A = 12;
        B = 2;
        ALUControl = 4'b1001;//: ALUResult = A >> B; // srl
        #10;

        A = 12;
        B = 2;
        ALUControl = 4'b1100;//: ALUResult = A < B; // slt, slti
        #10;
        ALUControl = 4'b1101;//: ALUResult = A > B; //sgt, sgti
        #10;
        
        A = -12;
        B = 2;
        ALUControl = 4'b1100;//: ALUResult = A < B; // slt, slti
        #10;
        ALUControl = 4'b1101;//: ALUResult = A > B; //sgt, sgti
        #10;
        
        A = 12;
        B = -2;
        ALUControl = 4'b1100;//: ALUResult = A < B; // slt, slti
        #10;
        ALUControl = 4'b1101;//: ALUResult = A > B; //sgt, sgti
        #10;
        
        A = -12;
        B = -2;
        ALUControl = 4'b1100;//: ALUResult = A < B; // slt, slti
        #10;
        ALUControl = 4'b1101;//: ALUResult = A > B; //sgt, sgti
        #10;
        
        A = -2;
        B = -12;
        ALUControl = 4'b1100;//: ALUResult = A < B; // slt, slti
        #10;
        ALUControl = 4'b1101;//: ALUResult = A > B; //sgt, sgti
        #10;
        



        
        $stop;
	end

endmodule

