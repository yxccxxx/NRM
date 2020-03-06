// Create Date:    2017.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file #(parameter W=8, D=4)(		 // W = data path width; D = pointer width
  input           CLK,
                  write_en,
  input  [ D-1:0] raddr,
                  waddr,
  input  [ W-1:0] data_in,
  output [ W-1:0] out_acc,
  output logic [W-1:0] out_reg
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0
assign out_acc = registers[15]; // accumulator register
assign out_reg = registers[raddr]; // the other input register

// sequential (clocked) writes 
always_ff @ (posedge CLK)
  // && waddr requires nonzero pointer address
  // if (write_en) if want to be able to write to address 0, as well
  if (write_en && waddr)	                             
    registers[waddr] <= data_in;

endmodule
