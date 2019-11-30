module graphicsUpgrades (clock, writeEn, x, y, colour);
input clock;
output writeEn;
output [8:0]x;
output [8:0] y;
output [3:0] colour;
wire [12:0] picAddress;


buildingOne B1 (picAddress, clock, colour);

drawUpgrades D1(.clock(clock), .writeEn(writeEn),.outputX(x), .outputY(y), .picAddress(picAddress));
	
endmodule

module drawUpgrades(clock, writeEn, outputX, outputY, picAddress);
input clock;
output reg writeEn;
output reg [8:0] outputX;
	output reg [8:0] outputY;
	output reg [9:0] picAddress;
	reg [8:0] xCounter;
	 reg [8:0] yCounter;
	 
	 always@(posedge clock)begin
	 writeEn <= 1'b1;
			picAddress <= yCounter * 50 + xCounter;
			if (picAddress <= 20'd2499) begin
				if (xCounter < 8'd51) begin
					outputX <= xCounter + 200;
					outputY<=  150 + yCounter;

					xCounter <= xCounter + 1'b1;
				end
				else begin
					xCounter <= 8'b0;
					if (yCounter < 8'd51)begin
						outputY<=  150 + yCounter;
						yCounter <= yCounter +1'b1;
					end
					else begin
						yCounter<=6'b0;
					end
					end
				end
				else
			begin
			picAddress <= 1'b0;
			yCounter <= 1'b0;
			xCounter <= 1'b0;
		end
			end
		endmodule
		