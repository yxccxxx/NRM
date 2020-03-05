//This file defines the parameters used in the alu
// CSE141L
package definitions;
    
// // Instruction map
//     const logic [2:0]kADD  = 3'b000;
//     const logic [2:0]kLSH  = 3'b001;
//     const logic [2:0]kRSH  = 3'b010;
//     const logic [2:0]kXOR  = 3'b011;
//     const logic [2:0]kAND  = 3'b100;
// 	const logic [2:0]kSUB  = 3'b101;
// 	const logic [2:0]kCLR  = 3'b110;
// // enum names will appear in timing diagram
//     typedef enum logic[2:0] {
//         ADD, LSH, RSH, XOR,
//         AND, SUB, CLR } op_mne;
// // note: kADD is of type logic[2:0] (3-bit binary)
// //   ADD is of type enum -- equiv., but watch casting
// //   see ALU.sv for how to handle this

// Instruction map
typedef enum logic[3:0] {
    ADD = 4'b0000;
    SUB = 4'b0001;
    BEQ = 4'b0010;
    SL = 4'b0011;
    SR = 4'b0100;
	LW = 4'b0101;
	SW = 4'b0110;
    INVERT = 4'b0111;
    MOV = 4'b1000;
	ASSIGN = 4'b1001;
	BGE = 4'b1010;
    BNE = 4'b1011;
    CLRSC = 4'b1100;
    OR = 4'b1101;
    JMP = 4'b1111;
} op_mne;

endpackage // definitions
