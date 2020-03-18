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
		done,           // program finishes running
  input [9:0] destination, // jump destination
  output logic halt, 	// program halts
  output logic[ 9:0] pc
  );

always @(posedge CLK)
  if(init) begin
    pc <= 0;
	halt <= 0;
  end
  else begin
	/** need to modify!!!!!! **/
    if(done) 
	  halt <= 1;		 // just a randomly chosen number 
	else if(jump_en) 
	  pc <= destination;
	//   if(counter[6] == 1)
	// 	PC <= PC - (7'b1111111 - (counter - 1));
	//   else
	// 	PC <= PC + counter;
	else if(branch_en)
	  pc <= pc + 2; // skip the next jump instruction to take the branch
	else 
	  pc <= pc + 1;	     // default == increment by 1
  end
endmodule
        