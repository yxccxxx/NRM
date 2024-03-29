// CSE141L
// program counter
// accepts branch and jump instructions
// default = increment by 1
// issues halt when PC reaches 63
module PC(
  input init,
        jump_en,		// relative
		branch_en,
		CLK,
  input [9:0] destination, // jump destination
  output logic halt, 	// program halts
  output logic[ 9:0] PC
  );

always @(posedge CLK)
  if(init) begin
    PC <= 0;
	halt <= 0;
  end
  else begin
    if(PC>63)
	  halt <= 1;		 // just a randomly chosen number 
	else if(jump_en) 
	  PC <= destination;
	//   if(counter[6] == 1)
	// 	PC <= PC - (7'b1111111 - (counter - 1));
	//   else
	// 	PC <= PC + counter;
	else if(branch_en)
	  PC <= PC + 2; // skip the next jump instruction to take the branch
	else 
	  PC <= PC + 1;	     // default == increment by 1
  end
endmodule
        