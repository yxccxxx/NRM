// Create Date:    15:50:22 10/02/2016 
// Design Name: 
// Module Name:    InstROM 
// Project Name:   CSE141L
// Tool versions: 
// Description: Verilog module -- instruction ROM template	
//	 preprogrammed with instruction values (see case statement)
//
// Revision: 
//
module InstROM #(parameter A=12, W=10) (
  input       [A-1:0] InstAddress,
  output logic[W-1:0] InstOut);

// alternative expression
//   need $readmemh or $readmemb to initialize all of the elements
  logic[W-1:0] inst_rom[2**(A)];
  always_comb InstOut = inst_rom[InstAddress];
 
  initial begin		                  // load from external text file
    $readmemb("int2float_machine.txt",inst_rom);
  	// $readmemb("float2int_machine.txt",inst_rom);
    // $readmemb("float_add_machine.txt",inst_rom);
  end 
  
endmodule
