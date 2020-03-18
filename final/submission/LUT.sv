// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[4:0] addr,
  output logic[9:0] Target
  );

always_comb 
  case(addr)	
 
    // int2flt
    5'b00000:    Target = 10'b0000001101;
    5'b00001:    Target = 10'b0000011001;
    5'b00010:    Target = 10'b0000011111;
    5'b00011:    Target = 10'b0000101100;
    5'b00100:    Target = 10'b0000111101;
    5'b00101:    Target = 10'b0001000111;
    5'b00110:    Target = 10'b0001101110;
    5'b00111:    Target = 10'b0001111000;
    5'b01000:    Target = 10'b0001111101;
    5'b01001:    Target = 10'b0010000111;
    5'b01010:    Target = 10'b0010010100;

    // // flt2int
    // 5'b00000:    Target = 10'b0000010110;
    // 5'b00001:    Target = 10'b0000100001;
    // 5'b00010:    Target = 10'b0000101001;
    // 5'b00011:    Target = 10'b0000110001;
    // 5'b00100:    Target = 10'b0000111001;
    // 5'b00101:    Target = 10'b0001000011;
    // 5'b00110:    Target = 10'b0001000110;
    // 5'b00111:    Target = 10'b0001001110;
    // 5'b01000:    Target = 10'b0001011010;

    // // flt_add
    // 5'b00000:    Target = 10'b0000110100;
    // 5'b00001:    Target = 10'b0000111101;
    // 5'b00010:    Target = 10'b0001000000;
    // 5'b00011:    Target = 10'b0001001010;
    // 5'b00100:    Target = 10'b0001010011;
    // 5'b00101:    Target = 10'b0001010011;
    // 5'b00110:    Target = 10'b0001100101;
    // 5'b00111:    Target = 10'b0001111110;
	default: Target = 16'h0;
  endcase

endmodule