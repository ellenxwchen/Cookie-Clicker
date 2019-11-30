`timescale 1ns / 1ns

module hexDecoder(input [3:0]binIn, output [6:0]HEX);

	wire [0:3]c = binIn;
	
	assign HEX[0] = ((~c[0] & ~c[1] & ~c[2] & c[3]) | (~c[0] & c[1] & ~c[2] & ~c[3]) | (c[0] & ~c[1] & c[2] & c[3]) | (c[0] & c[1] & ~c[2] & c[3]));
	assign HEX[1] = ((~c[0] & c[1] & ~c[2] & c[3]) | (~c[0] & c[1] & c[2] & ~c[3]) | (c[0] & ~c[1] & c[2] & c[3]) | (c[0] & c[1] & ~c[2] & ~c[3])| (c[0] & c[1] & c[2] & ~c[3]) | (c[0] & c[1] & c[2] & c[3]));
	assign HEX[2] = ((~c[0] & ~c[1] & c[2] & ~c[3]) | (c[0] & c[1] & ~c[2] & ~c[3]) | (c[0] & c[1] & c[2] & ~c[3]) | (c[0] & c[1] & c[2] & c[3]));
	assign HEX[3] = ((~c[0] & ~c[1] & ~c[2] & c[3]) | (~c[0] & c[1] & ~c[2] & ~c[3]) | (~c[0] & c[1] & c[2] & c[3]) | (c[0] & ~c[1] & ~c[2] & c[3])| (c[0] & ~c[1] & c[2] & ~c[3]) | (c[0] & c[1] & c[2] & c[3]));
	assign HEX[4] = ((~c[0] & ~c[1] & ~c[2] & c[3]) | (~c[0] & ~c[1] & c[2] & c[3]) | (~c[0] & c[1] & ~c[2] & ~c[3]) | (~c[0] & c[1] & ~c[2] & c[3])| (~c[0] & c[1] & c[2] & c[3]) | (c[0] & ~c[1] & ~c[2] & c[3]));
	assign HEX[5] = ((~c[0] & ~c[1] & ~c[2] & c[3]) | (~c[0] & ~c[1] & c[2] & ~c[3]) | (~c[0] & ~c[1] & c[2] & c[3]) | (~c[0] & c[1] & c[2] & c[3])| (c[0] & c[1] & ~c[2] & c[3]));
	assign HEX[6] = ((~c[0] & ~c[1] & ~c[2] & ~c[3]) | (~c[0] & ~c[1] & ~c[2] & c[3]) | (~c[0] & c[1] & c[2] & c[3]) | (c[0] & c[1] & ~c[2] & ~c[3]));
	
endmodule