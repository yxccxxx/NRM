// test bench for float to integer
// CSE141L
module flt2int_tb();
  logic clk = '0, reset='1;
  logic[15:0] flt_in = '0;
  logic signed[5:0] exp;		 // de-biased exponent in
  logic[10:0] mant;              // significand in
  real int_equiv;                // computed value of integer 
  real mant2;					 // real equiv. of mant.
  logic[15:0] int_out;			 // two's comp. result
  wire  ack;					 // from DUT
  logic req;
  int count, agree;
  flt2int f2(.*);				 // DUT goes here
									    
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end
  initial begin
//    $monitor(flt_in,,,int_out);
    #20ns reset = '0;
	flt_in = '0;
    disp;	                       // task call
	flt_in = 16'b0_01111_0000000000;
    disp;
    flt_in = 16'b0_01111_1000000000;
	disp;
	flt_in = 16'b0_01111_0100000000;
    disp;
    flt_in = 16'b0_01111_1100000000;
	disp;
    flt_in = 16'b0_10000_0000000000;
    disp;
    flt_in = 16'b0_10000_1000000000;
    disp;
    flt_in = 16'b0_10000_1100000000;
    disp;
    flt_in = 16'b0_10000_1110000000;
    disp;
    flt_in = 16'b0_10000_0001000000;
    disp;
    flt_in = 16'b0_10000_0001000000;
    disp;
    flt_in = 16'b0_10000_0101000000;
    disp;
    flt_in = 16'b0_10000_0111000000;
    disp;
	flt_in = 16'b0_10010_1100000000;
	disp;
	flt_in = 16'b0_10010_1110000000;
	disp;
	flt_in = 16'b0_11000_1100000000;
	disp;
	flt_in = 16'b0_11001_1100000000;
	disp;
	flt_in = 16'b0_11101_1110000000;
	disp;
	flt_in = 16'b0_11110_1110000000;
	disp;
	#20ns $display(agree,,,count); 
	$stop; 
  end
  task disp();
    #10ns req = '1;
    {f2.dm1.mem_core[4],f2.dm1.mem_core[5]} = flt_in;
    exp = flt_in[14:10]-15;	     // remove exponent bias      
    mant[10] = |flt_in[14:10];	 // restore hidden bit
    mant[9:0] = flt_in[ 9: 0];	 // parse mantissa fraction
    mant2 = mant/1024.0;		 // equiv. floating point value of mant.
    #10ns req = '0;
	wait(ack);
	int_equiv = mant2 * 2**exp;
	if(int_equiv > 2**15-1) int_equiv = 2**15-1; // limiter
	int_out   = int_equiv;
    #20ns $display("%f * 2**%d = %f = %d",mant2,exp,int_equiv,int_out);
    #20ns $display("from DUT = %b = %d",{f2.dm1.mem_core[6],f2.dm1.mem_core[7]},
        {f2.dm1.mem_core[6],f2.dm1.mem_core[7]});
	count++;
	if(int_out == {f2.dm1.mem_core[6],f2.dm1.mem_core[7]}) agree++;
	$display();
  endtask
endmodule

