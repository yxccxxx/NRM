// Create Date:    2018.04.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
    input     start,	   // init/reset, active high
	input     CLK,		   // clock -- posedge used inside design
    output    halt		   // done flag from DUT
    );

wire [ 9:0] PC;            // program count
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] out_acc, 
			out_reg;       // reg_file outputs
wire [ 7:0] InA, InB, 	   // ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] regWriteValue, // data in to reg file
            memWriteValue, // data in to data_memory
	   	    Mem_Out;	   // data out from data_memory
wire        MEM_READ,	   // data_memory read enable
		    MEM_WRITE,	   // data_memory write enable
			reg_wr_en,	   // reg_file write enable
			sc_clr,        // carry reg clear
			sc_en,	       // carry reg enable
		    SC_OUT,	       // to carry register
			ZERO,		   // ALU output = 0 flag
			BEVEN,		   // ALU input B is even flag
            jump_en,	   // to program counter: jump enable
            branch_en;	   // to program counter: branch enable
logic[15:0] cycle_ct;	   // standalone; NOT PC!
logic       SC_IN;         // carry register (loop with ALU)

  	// Fetch = Program Counter + Instruction ROM
  	// Program Counter
  	PC PC (
		.init       (start), 
		.jump_en           ,  // jump enable
		.branch_en	       ,  // branch enable
		.CLK        (CLK)  ,  // (CLK) is required in Verilog, optional in SystemVerilog
		.counter           ,  // how many instructions pc needs to jump
		.halt              ,  // SystemVerilg shorthand for .halt(halt), 
		.PC             	  // program count = index to instruction memory
	);					  

  	// Control decoder
  	Ctrl Ctrl (
		.Instruction,    // from instr_ROM
		.ZERO,			 // from ALU: result = 0
		.BEVEN,			 // from ALU: input B is even (LSB=0)
		.jump_en,		 // to PC
		.sc_en,          // carry reg enable
		.sc_clr,         // carry reg clear
		.reg_exe,        // register and accumulator execution
		.imm_exe,        // immediate and accumulator execution
		.mem_to_reg,     // get value from memory to register
		.reg_to_mem,     // store value from register to memory
		.reg_to_acc,     // store value from register to accumulator
		.acc_to_reg,     // store value from accumulator to register
		.assign_val      // assign value to accumulator
  	);

  	// instruction ROM
	InstROM instr_ROM(
		.InstAddress   (PC), 
		.InstOut       (Instruction)
	);

  	assign load_inst = Instruction[8:6]==3'b110;  // calls out load specially

	// reg file
	reg_file #(.W(8),.D(4)) reg_file (
		.CLK    				  ,
		.write_en  (reg_wr_en)    , 
		.raddr    ({1'b0,Instruction[5:3]}),         //concatenate with 0 to give us 4 bits
		.waddr     ({1'b0,Instruction[5:3]+1}), 	  // mux above
		.data_in   (regWriteValue) , 
		.out_acc 				  , 
		.out_reg
	);
	// one pointer, two adjacent read accesses: (optional approach)
	//	.raddrA ({Instruction[5:3],1'b0});
	//	.raddrB ({Instruction[5:3],1'b1});

    assign InA = ReadA;						          // connect RF out to ALU in
	assign InB = ReadB;
	assign MEM_WRITE = (Instruction == 9'h111);       // mem_store command
	assign regWriteValue = load_inst? Mem_Out : ALU_out;  // 2:1 switch into reg_file
    ALU ALU  (
	  	.reg_acc  (InA),
	  	.reg_in  (InB), 
	  	.imm_in,
		.OP      (Instruction[8:5]),
	  	.SC_IN   ,//(SC_IN),
	  	.reg_exe,
	  	.imm_exe,
	  	.reg_to_acc,
	  	.acc_to_reg,
	  	.OUT     (ALU_out),//regWriteValue),
	  	.SC_OUT  ,
	  	.ZERO ,
	  	.BEVEN,
	  	.BRANCH
	);
  
	data_mem data_mem(
		.DataAddress  (ReadA)    , 
		.ReadMem      (1'b1),          //(MEM_READ) ,   always enabled 
		.WriteMem     (MEM_WRITE), 
		.DataIn       (memWriteValue), 
		.DataOut      (Mem_Out)  , 
		.CLK 		  		     ,
		.reset		  (start)
	);
	
// count number of instructions executed
always_ff @(posedge CLK)
  	if (start == 1)	   // if(start)
  		cycle_ct <= 0;
  	else if(halt == 0)   // if(!halt)
  		cycle_ct <= cycle_ct+16'b1;

always_ff @(posedge CLK)    // carry/shift in/out register
  	if(sc_clr)				// tie sc_clr low if this function not needed
   		SC_IN <= 0;             // clear/reset the carry (optional)
  	else if(sc_en)			// tie sc_en high if carry always updates on every clock cycle (no holdovers)
    	SC_IN <= SC_OUT;        // update the carry  

endmodule
