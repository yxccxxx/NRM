// Create Date:    2016.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2018.01.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			  // includes package "definitions"
module ALU(
  input [ 7:0] reg_acc,      	  // accumulator register
               reg_in,          // input register
               imm_in,          // input immediate
  input [ 3:0] OP,				      // ALU opcode, part of microcode
  input        SC_IN,           // shift in/carry in 
  input        reg_exe,         // register execution flag
               imm_exe,         // immediate execution flag
               reg_to_acc,      // value from reg to acc flag
               acc_to_reg,      // value from acc to reg flag
  output logic [7:0] OUT,		    // or:  output reg [7:0] OUT,
  output logic SC_OUT,			    // shift out/carry out
  output logic ZERO,            // zero out flag
  output logic BEVEN,           // LSB of input B = 0
  output logic branch_en           // pc = pc + 2 if branch_en = 1, pc++ if branch_en = 0
  );
	 
  op_mne op_mnemonic;			      // type enum: used for convenient waveform viewing
	
  always_comb begin
    {SC_OUT, OUT} = 0;          // default -- clear carry out and result out
    branch_en = 0;

  case(OP)
    ADD: begin
      if(reg_exe == 1)
        {SC_OUT, OUT} = {1'b0,reg_acc} + reg_in + SC_IN;
      else
        {SC_OUT, OUT} = {1'b0,reg_acc} + imm_in + SC_IN;
      end
    SUB: begin
      // if(reg_exe == 1)
      //   {SC_OUT, OUT} = {1'b0,reg_acc} - reg_in + SC_IN;
      // else
      //   {SC_OUT, OUT} = {1'b0,reg_acc} - imm_in + SC_IN;
      if(reg_exe == 1)
        {SC_OUT, OUT} = {1'b1, reg_acc} - reg_in - SC_IN;
	    else
        {SC_OUT, OUT} = {1'b1, reg_acc} - imm_in - SC_IN;
      SC_OUT = ~SC_OUT;
	    end
    BEQ: begin
      if(reg_exe == 1) begin
        if(reg_in == reg_acc)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      else begin
        if(imm_in == reg_acc)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      end
    SL: {SC_OUT, OUT} = {reg_in, SC_IN}; 
    SR: {OUT, SC_OUT} = {SC_IN, reg_in}; 
    LW: ;
    SW: OUT = reg_in;
    MOV: begin
      if(reg_to_acc)
        OUT = reg_in;
      else
        OUT = reg_acc;
      end
    ASSIGN: OUT = imm_in;
    BGE: begin
      if(reg_exe == 1) begin
        if(reg_acc >= reg_in)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      else begin
        if(reg_acc >= imm_in)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      end
    BNE: begin
      if(reg_exe == 1) begin
        if(reg_in != reg_acc)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      else begin
        if(imm_in != reg_acc)
          branch_en = 0; // pc = pc + 1, move to jump
        else
          branch_en = 1; // pc = pc + 2
        end
      end
    AND: begin
      if(reg_exe == 1)
        OUT = reg_acc & reg_in;
      else
        OUT = reg_acc & imm_in;
      end
    OR: begin
      if(reg_exe == 1)
        OUT = reg_acc | reg_in;
      else
        OUT = reg_acc | imm_in;
      end
    default: {SC_OUT,OUT} = 0;
  endcase

	case(OUT)
	  'b0     : ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase
    //$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);					  // displays operation name in waveform viewer
  end											
  always_comb BEVEN = OUT[0];          			  // note [0] -- look at LSB only
//    OP == 3'b101; //!INPUTB[0];               
// always_comb	branch_en_enable = opcode[8:6]==3'b101? 1 : 0;  
endmodule


/* Left shift
input a = 10110011   sc_in = 1
output = 01100111
sc_out =	1
*/