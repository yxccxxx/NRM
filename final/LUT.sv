// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[4:0] addr,
  output logic[9:0] Target
  );

always_comb 
  case(addr)	
    // program 1	  
    5'b00000:  Target = 10'b0000010011;
    5'b00001:	 Target = 10'b0000100000;
    5'b00010:	 Target = 10'b0000010011;
    5'b00011:	 Target = 10'b0000010011;
    5'b00100:	 Target = 10'b0000111100;
    5'b00101:	 Target = 10'b0000110010;
    5'b00110:	 Target = 10'b0001001011;
    5'b00111:	 Target = 10'b0001000001;

    // // program 2
    // 5'b00000:  Target = 10'b0000010110;
    // 5'b00001:	 Target = 10'b0001001110;
    // 5'b00010:	 Target = 10'b0001000001;
    // 5'b00011:	 Target = 10'b0000110100;
    // 5'b00100:	 Target = 10'b0000101001;
    // 5'b00101:	 Target = 10'b0000101100;
    // 5'b00110:	 Target = 10'b0000011111;
    // 5'b00111:	 Target = 10'b0001001110;
    // 5'b01000:	 Target = 10'b0001001110;
    // 5'b01001:	 Target = 10'b0001000110;

    // // program 3
    // 5'b00000:  Target = 10'b0000111101;
    // 5'b00001:	 Target = 10'b0000111101;
    // 5'b00010:	 Target = 10'b0000110100;
    // 5'b00011:	 Target = 10'b0001010010;
    // 5'b00100:	 Target = 10'b0001010000;
    // 5'b00101:	 Target = 10'b0001000111;
    // 5'b00110:	 Target = 10'b0001100100;

	default: Target = 16'h0;
  endcase

endmodule