// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[4:0] addr,
  output logic[9:0] Target
  );

always_comb 
  case(addr)	
    // // program 1	  
    // 5'b00000:  Target = 10'b0000001101;
    // 5'b00001:	 Target = 10'b0010010010;
    // 5'b00010:	 Target = 10'b0000011001;
    // 5'b00011:	 Target = 10'b0000101100;
    // 5'b00100:	 Target = 10'b0000011111;
    // 5'b00101:	 Target = 10'b0000101100;
    // 5'b00110:	 Target = 10'b0000011111;
    // 5'b00111:	 Target = 10'b0000011111;
    // 5'b01000:  Target = 10'b0001000111;
    // 5'b01001:  Target = 10'b0000111101;
    // 5'b01010:  Target = 10'b0001101100;
    // 5'b01011:  Target = 10'b0001110110;
    // 5'b01100:  Target = 10'b0001110110;
    // 5'b01101:  Target = 10'b0001110110;
    // 5'b01110:  Target = 10'b0010000101;
    // 5'b01111:  Target = 10'b0001111011;

    // program 2 NEED TO CHANGE BASED ON assembler output
    5'b00000:  Target = 10'b0000010110;
    5'b00001:	 Target = 10'b0001001111;
    5'b00010:	 Target = 10'b0000100110;
    5'b00011:	 Target = 10'b0001001111;
    5'b00100:	 Target = 10'b0000011110;
    5'b00101:	 Target = 10'b0001000011;
    5'b00110:	 Target = 10'b0000111000;
    5'b00111:	 Target = 10'b0000111011;
    5'b01000:	 Target = 10'b0000101110;

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