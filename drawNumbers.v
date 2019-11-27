module drawNumbers(reset, clock, writeEn, initialX, initialY, outputX, outputY, picAddress);
	//parameter WIDTH = 20;
	//parameter HEIGHT = 32;
	
	input clock;
	input reset;
	output reg writeEn;
	input [8:0] initialX;
	input [8:0] initialY;
	output reg [8:0] outputX;
	output reg [8:0] outputY;
	output reg [11:0] picAddress;
	
	 reg [8:0] xCounter;
	 reg [8:0] yCounter;
	
	always@(posedge clock)begin
		if (reset) begin
			outputX<=8'd0;
			outputY<=8'd0;
			xCounter<=9'b0;
			yCounter<=9'b0;
			picAddress<=9'b0;
			writeEn <= 1'b0;
			
		end
		else begin
			writeEn <= 1'b1;
			//outputX <= initialX;
			//outputY	<= initialY;
			if (picAddress <= 20'd639) begin
				
				if (xCounter < 5'd20) begin
					outputX <= xCounter + initialX;
					outputY<=  initialY + yCounter;

					xCounter <= xCounter + 1'b1;
					picAddress <= picAddress + 1'b1;
				end
				else begin
					xCounter <= 6'b0;
					if (yCounter < 6'd32)begin
						picAddress<= picAddress + 1'b1;
						outputY<=  initialY + yCounter;
						yCounter <= yCounter +1'b1;
						xCounter <= 6'b0;
					end
					else begin
						outputX <= 1'b0;
					end
				
	//				else begin
	//					yCounter<= 6'b0;
	//				end
					end
				end
			else 
				picAddress <= 20'd0;
			end
		end

		endmodule
