`timescale 1ns / 1ns

module rateDivider(clock, pulse);

	input clock;
	output pulse;
	
	reg [27:0]Q = 0;
	
	always@(posedge clock)begin
	
		if(Q == 0)
			Q <= 25000000;
		else 
			Q <= Q - 1;
	
	end
	
	assign pulse = (Q == 0) ? 1 : 0;

endmodule