`timescale 1ns / 1ns

module prevData(clock, received_data_en, received_data, prev_data);

	input clock, received_data_en;
	input [7:0]received_data;
	
	output reg [7:0] prev_data;
	
	reg [7:0] current_data = 0;
	
	always@(posedge clock)begin
	
		if(received_data_en)begin
			prev_data = current_data;
			current_data = received_data;
		end
		else
			prev_data = 0;
	end
	
endmodule