module graphicsNumber (clock, writeEn, Millions, HundredThousands, TenThousands, Thousands, Hundred, Tens, Ones, outputX, outputY, colour);
	 input clock;
	 output writeEn;
	 input [3:0] Millions, HundredThousands, TenThousands, Thousands, Hundred, Tens, Ones;
	 output [8:0] outputX, outputY;
	//output reg [11:0] picAddress;
	output [2:0] colour;
	
	wire [9:0] numberAddress0;
	wire [9:0] numberAddress1;
	wire [9:0] numberAddress2;
	wire [9:0] numberAddress3;
	wire [9:0] numberAddress4;
	wire [9:0] numberAddress5;
	wire [9:0] numberAddress6;
	wire [9:0] numberAddress7;
	wire [9:0] numberAddress8;
	wire [9:0] numberAddress9;
	
	wire [9:0] picAddress;
	
	wire [2:0] numberColour0;
	wire [2:0] numberColour1;
	wire [2:0] numberColour2;
	wire [2:0] numberColour3;
	wire [2:0] numberColour4;
	wire [2:0] numberColour5;
	wire [2:0] numberColour6;
	wire [2:0] numberColour7;
	wire [2:0] numberColour8;
	wire [2:0] numberColour9;
	
	number0 N0 (numberAddress0, clock, numberColour0);
	number1 N1 (numberAddress1, clock, numberColour1);
	number2 N2 (numberAddress2, clock, numberColour2);
	number3 N3 (numberAddress3, clock, numberColour3);
	number4 N4 (numberAddress4, clock, numberColour4);
	number5 N5 (numberAddress5, clock, numberColour5);
	number6 N6 (numberAddress6, clock, numberColour6);
	number7 N7 (numberAddress7, clock, numberColour7);
	number8 N8 (numberAddress8, clock, numberColour8);
	number9 N9 (numberAddress9, clock, numberColour9);
	
	wire done;
	
	wire [8:0] initialX, initialY;
	wire drawMill, drawHundThous, drawTenThous , drawThous, drawHund,drawTens,drawOnes;
	
	datapath D1 (clock, drawMill, drawHundThous, drawTenThous , drawThous, drawHund,drawTens, drawOnes, picAddress, Millions, 
	HundredThousands, TenThousands, Thousands, Hundred, Tens, Ones, numberColour0,numberColour1,numberColour2,numberColour3,numberColour4,numberColour5,
	numberColour6,numberColour7,numberColour8,numberColour9,numberAddress0, numberAddress1, numberAddress2, numberAddress3, numberAddress4, numberAddress5, 
	numberAddress6, numberAddress7, numberAddress8, numberAddress9, colour, initialX, initialY);
	control C1 (clock, done, drawMill, drawHundThous, drawTenThous, drawThous, drawHund,drawTens,drawOnes);

	drawNumbers D0(.clock(clock), .done(done),.writeEn(writeEn), .initialX(initialX), .initialY(initialY), .outputX(outputX), .outputY(outputY), .picAddress(picAddress));
	
endmodule

module control(
	input clock,
	input done,
	output reg drawMill, drawHundThous, drawTenThous, drawThous, drawHund,drawTens,drawOnes);
	reg [2:0]currentState, nextState;
	localparam S_DRAWMILL = 5'd0,
					S_DRAWHUNDTHOUS = 5'd1,
					S_DRAWTENTHOUS = 5'd2,
					S_DRAWTHOUS = 5'd3,
					S_DRAWHUND = 5'd4,
					S_DRAWTENS = 5'd5,
					S_DRAWONES = 5'd6;
always@(*)begin
	case(currentState)
		S_DRAWMILL: nextState = done? S_DRAWHUNDTHOUS : S_DRAWMILL;
		S_DRAWHUNDTHOUS: nextState = done? S_DRAWTENTHOUS : S_DRAWHUNDTHOUS;
		S_DRAWTENTHOUS: nextState = done? S_DRAWTHOUS : S_DRAWTENTHOUS;
		S_DRAWTHOUS: nextState = done? S_DRAWHUND :S_DRAWTHOUS;
		S_DRAWHUND: nextState = done? S_DRAWTENS: S_DRAWHUND;
		S_DRAWTENS: nextState = done? S_DRAWONES:S_DRAWTENS;
		S_DRAWONES: nextState = done? S_DRAWMILL: S_DRAWONES;
		default: nextState= S_DRAWMILL;
	endcase
end	

always@(posedge clock) begin
	currentState<=nextState;
end

always@(*)begin
	drawMill = 1'b0;
	drawHundThous = 1'b0;
	drawTenThous = 1'b0;
	drawThous = 1'b0;
	drawHund = 1'b0;
	drawTens = 1'b0;
	drawOnes = 1'b0;
	case(currentState)
		S_DRAWMILL: begin
		drawMill = 1'b1;
		end
		S_DRAWHUNDTHOUS: begin
		drawHundThous = 1'b1;
		end
		S_DRAWTENTHOUS: begin
		drawTenThous = 1'b1;
		end
		S_DRAWTHOUS: begin
		drawThous = 1'b1;
		end
		S_DRAWHUND: begin
		drawHund = 1'b1;
		end
		S_DRAWTENS: begin
		drawTens = 1'b1;
		end
		S_DRAWONES: begin
		drawOnes = 1'b1;
		end
	endcase
end
endmodule

module datapath(
		input clock,
		input drawMill, drawHundThous, drawTenThous, drawThous, drawHund,drawTens, drawOnes,
		input [9:0] picAddress,
		input [3:0] Millions, HundredThousands, TenThousands, Thousands, Hundred, Tens, Ones, 
		input [2:0] numberColour0,numberColour1,numberColour2,numberColour3,numberColour4,numberColour5,numberColour6,numberColour7,numberColour8,numberColour9,
		output reg [9:0] numberAddress0, numberAddress1, numberAddress2, numberAddress3, numberAddress4, numberAddress5, numberAddress6, numberAddress7, numberAddress8, numberAddress9,
		output reg [2:0]colour,
		output reg [8:0]initialX, initialY);
always@(posedge clock)begin
	initialY <= 8'd220;
	if (drawMill) begin
	initialX <= 8'd180;
		case(Millions)
			4'd0: begin
				numberAddress0 <= picAddress;
				colour <= numberColour0;
				end
			4'd1: begin
				numberAddress1 <= picAddress;
				colour <= numberColour1;
				end
			4'd2: begin
				numberAddress2 <= picAddress;
				colour <= numberColour2;
				end
			4'd3: begin
				numberAddress3 <= picAddress;
				colour <= numberColour3;
				end
			4'd4: begin
				numberAddress4 <= picAddress;
				colour <= numberColour4;
				end
			4'd5: begin
				numberAddress5 <= picAddress;
				colour <= numberColour5;
				end
			4'd6: begin
				numberAddress6 <= picAddress;
				colour <= numberColour6;
				end
			4'd7: begin
				numberAddress7 <= picAddress;
				colour <= numberColour7;
				end
			4'd8: begin
				numberAddress8 <= picAddress;
				colour <= numberColour8;
				end
			4'd9: begin
				numberAddress9 <= picAddress;
				colour <= numberColour9;
				end
		endcase
		end
	if (drawHundThous)begin
	initialX <= 8'd200;
	case(HundredThousands) 
		4'd0: begin
			numberAddress0 <= picAddress;
			colour <= numberColour0;
			end
		4'd1: begin
		numberAddress1 <= picAddress;
			colour <= numberColour1;
			end
		4'd2: begin
		numberAddress2 <= picAddress;
			colour <= numberColour2;
			end
		4'd3: begin
			numberAddress3 <= picAddress;
			colour <= numberColour3;
			end
		4'd4: begin
			numberAddress4 <= picAddress;
			colour <= numberColour4;
			end
		4'd5: begin
			numberAddress5 <= picAddress;
			colour <= numberColour5;
			end
		4'd6: begin
			numberAddress6 <= picAddress;
			colour <= numberColour6;
			end
		4'd7: begin
			numberAddress7 <= picAddress;
			colour <= numberColour7;
			end
		4'd8: begin
			numberAddress8 <= picAddress;
			colour <= numberColour8;
			end
		4'd9: begin
			numberAddress9 <= picAddress;
			colour <= numberColour9;
			end
	endcase
	end
	if (drawTenThous) begin
	initialX <= 8'd220;
	case(TenThousands) 
		4'd0: begin
			numberAddress0 <= picAddress;
			colour <= numberColour0;
			end
		4'd1: begin
			numberAddress1 <= picAddress;
			colour <= numberColour1;
			end
		4'd2: begin
			numberAddress2 <= picAddress;
			colour <= numberColour2;
			end
		4'd3: begin
			numberAddress3 <= picAddress;
			colour <= numberColour3;
			end
		4'd4: begin
			numberAddress4 <= picAddress;
			colour <= numberColour4;
			end
		4'd5: begin
			numberAddress5 <= picAddress;
			colour <= numberColour5;
			end
		4'd6: begin
			numberAddress6 <= picAddress;
			colour <= numberColour6;
			end
		4'd7: begin
			numberAddress7 <= picAddress;
			colour <= numberColour7;
			end
		4'd8: begin
			numberAddress8 <= picAddress;
			colour <= numberColour8;
			end
		4'd9: begin
			numberAddress9 <= picAddress;
			colour <= numberColour9;
			end
	endcase
	end
	if (drawThous) begin
	initialX <= 8'd240;
		case(Thousands) 
			4'd0: begin
				numberAddress0 <= picAddress;
				colour <= numberColour0;
				end
			4'd1: begin
				numberAddress1 <= picAddress;
				colour <= numberColour1;
				end
			4'd2: begin
				numberAddress2 <= picAddress;
				colour <= numberColour2;
				end
			4'd3: begin
				numberAddress3 <= picAddress;
				colour <= numberColour3;
				end
			4'd4: begin
				numberAddress4 <= picAddress;
				colour <= numberColour4;
				end
			4'd5: begin
				numberAddress5 <= picAddress;
				colour <= numberColour5;
				end
			4'd6: begin
				numberAddress6 <= picAddress;
				colour <= numberColour6;
				end
			4'd7: begin
				numberAddress7 <= picAddress;
				colour <= numberColour7;
				end
			4'd8: begin
				numberAddress8 <= picAddress;
				colour <= numberColour8;
				end
			4'd9: begin
				numberAddress9 <= picAddress;
				colour <= numberColour9;
				end
		endcase
		end
	if (drawHund) begin
	initialX <= 11'd260;
		case(Hundred) 
			4'd0: begin
				numberAddress0 <= picAddress;
				colour <= numberColour0;
				end
			4'd1: begin
				numberAddress1 <= picAddress;
				colour <= numberColour1;
				end
			4'd2: begin
			numberAddress2 <= picAddress;
				colour <= numberColour2;
				end
			4'd3: begin
			numberAddress3 <= picAddress;
				colour <= numberColour3;
				end
			4'd4: begin
			numberAddress4 <= picAddress;
				colour <= numberColour4;
				end
			4'd5: begin
			numberAddress5 <= picAddress;
				colour <= numberColour5;
				end
			4'd6: begin
			numberAddress6 <= picAddress;
				colour <= numberColour6;
				end
			4'd7: begin
			numberAddress7 <= picAddress;
				colour <= numberColour7;
				end
			4'd8: begin
			numberAddress8 <= picAddress;
				colour <= numberColour8;
				end
			4'd9: begin
			numberAddress9 <= picAddress;
				colour <= numberColour9;
				end
		endcase
		end
	if (drawTens) begin
	initialX <= 11'd280;
		case(Tens) 
			4'd0: begin
				numberAddress0 <= picAddress;
				colour <= numberColour0;
				end
			4'd1: begin
				numberAddress1 <= picAddress;
				colour <= numberColour1;
				end
			4'd2: begin
				numberAddress2 <= picAddress;
				colour <= numberColour2;
				end
			4'd3: begin
				numberAddress3 <= picAddress;
				colour <= numberColour3;
				end
			4'd4: begin
				numberAddress4 <= picAddress;
				colour <= numberColour4;
				end
			4'd5: begin
				numberAddress5 <= picAddress;
				colour <= numberColour5;
				end
			4'd6: begin
				numberAddress6 <= picAddress;
				colour <= numberColour6;
				end
			4'd7: begin
				numberAddress7 <= picAddress;
				colour <= numberColour7;
				end
			4'd8: begin
				numberAddress8 <= picAddress;
				colour <= numberColour8;
				end
			4'd9: begin
				numberAddress9 <= picAddress;
				colour <= numberColour9;
				end
		endcase
		end
	if (drawOnes) begin
	initialX <= 11'd300;
	case(Ones) 
		4'd0: begin
			numberAddress0 <= picAddress;
			colour <= numberColour0;
			end
		4'd1: begin
			numberAddress1 <= picAddress;
			colour <= numberColour1;
			end
		4'd2: begin
			numberAddress2 <= picAddress;
			colour <= numberColour2;
			end
		4'd3: begin
			numberAddress3 <= picAddress;
			colour <= numberColour3;
			end
		4'd4: begin
			numberAddress4 <= picAddress;
			colour <= numberColour4;
			end
		4'd5: begin
			numberAddress5 <= picAddress;
			colour <= numberColour5;
			end
		4'd6: begin
			numberAddress6 <= picAddress;
			colour <= numberColour6;
			end
		4'd7: begin
			numberAddress7 <= picAddress;
			colour <= numberColour7;
			end
		4'd8: begin
			numberAddress8 <= picAddress;
			colour <= numberColour8;
			end
		4'd9: begin
			numberAddress9 <= picAddress;
			colour <= numberColour9;
			end
	endcase
	end
end
	
endmodule

module drawNumbers(reset, done, clock, writeEn, initialX, initialY, outputX, outputY, picAddress);
	//parameter WIDTH = 10;
	//parameter HEIGHT = 16;
	
	input clock;
	input reset;
	output reg done;
	output reg writeEn;
	input [8:0] initialX;
	input [8:0] initialY;
	output reg [8:0] outputX;
	output reg [8:0] outputY;
	output reg [11:0] picAddress;
	
	 reg [8:0] xCounter;
	 reg [8:0] yCounter;
	
	always@(posedge clock)begin
		done<=1'd0;
		if (reset) begin
			outputX<=8'd0;
			outputY<=8'd0;
			xCounter<=9'b0;
			yCounter<=9'b0;
			picAddress<=9'b0;
			writeEn <= 1'b0;
			done <=1'd0;

		end
		else begin
			writeEn <= 1'b1;
			//done<=1'd0;
			picAddress <= yCounter * 10 + xCounter;
			if (picAddress <= 20'd159) begin
				
				if (xCounter < 5'd11) begin
					outputX <= xCounter + initialX;
					outputY<=  initialY + yCounter;

					xCounter <= xCounter + 1'b1;
				end
				else begin
					xCounter <= 6'b0;
					if (yCounter < 6'd17)begin
						outputY<=  initialY + yCounter;
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
			done <= 1'd1;
		end
		end
	end
	
	endmodule
