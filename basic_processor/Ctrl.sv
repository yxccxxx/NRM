// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	   // machine code
  output logic ZERO,			     // from ALU: result = 0
		           BEVEN,	         // from ALU: input B is even (LSB=0)
               jump_en,        // jump enabled
               sc_en,          // carry reg enable
               sc_clr,         // carry reg clear
               reg_exe,        // register and accumulator execution
               imm_exe,        // immediate and accumulator execution
               mem_to_reg,     // get value from memory to register
               reg_to_mem,     // store value from register to memory
               reg_to_acc,     // store value from register to accumulator
               acc_to_reg,     // store value from accumulator to register
               assign_val      // assign int to accumulator
  );
// jump on right shift that generates a zero
always_comb begin
  jump_en = 0;
  sc_en = 0;
  sc_clr = 0;
  reg_exe = 0;
  imm_exe = 0;
  mem_to_reg = 0;
  reg_to_mem = 0;
  reg_to_acc = 0;
  acc_to_reg = 0;
  assign_val = 0;

  case(Instruction[8:5])
    LW: mem_to_reg = 1;
    SW: reg_to_mem = 1;
    ASSIGN: assign_val = 1;
    CLRSC: sc_clr = 1;
  endcase
end
  // if(Instruction[8:5] == JMP)
  //   jump_en = 1;
  // else
  //   jump_en = 0;

  // if(Instruction[8:5] == ADD || Instruction[8:5] == SUB || 
  //   Instruction[8:5] == BEQ || Instruction[8:5] == AND ||
  //   Instruction[8:5] == OR || Instruction[8:5] == BGE ||
  //   Instruction[8:5] == BNE) begin

  //   if(Instruction[4] == 0) begin
  //     reg_exe = 1
  //     imm_exe = 0
  //     end
  //   else begin
  //     reg_exe = 0
  //     imm_exe = 1
  //     end
  //   end
  // else begin
  //   reg_exe = 0
  //   imm_exe = 0
  //   end

  // if(Instruction[8:5] == LW)
  //   mem_to_reg = 1
  // else
  //   mem_to_reg = 0

  // if(Instruction[8:5] == SW)
  //   reg_to_mem = 1
  // else
  //   reg_to_mem = 0

  // if(Instruction[8:5] == ASSIGN)
  //   assign_val = 1
  // else
  //   assign_val = 0

  // if(Instruction[8:5] == MOV) begin
  //   if(Instruction[4] == 0) begin
  //     reg_to_acc = 1
  //     acc_to_reg = 0
  //     end
  //   else begin
  //     reg_to_acc = 0
  //     acc_to_reg = 1
  //     end
  //   end

  // if(Instruction[8:5] == CLRSC) 
  //   sc_clr = 1
    
  // else begin
  //   reg_to_acc = 0
  //   acc_to_reg = 0
  //   end

endmodule