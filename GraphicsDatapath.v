module graphicsDatapath(clock, pulse, money, selectedAsset, drawSelection, drawUpgrade, drawMoney, black, x, y, plot, colour);

	input clock, pulse, drawSelection, drawUpgrade, drawMoney, black;
	input [39:0] money;
	input [7:0] selectedAsset;
	
	output reg plot;
	output reg[8:0] x, y;
	output reg[2:0] colour;
	
	reg [8:0] xi, yi, count;
	reg [6:0] currentStep = 0;
	reg [6:0] nextStep;
	reg start;
	reg [12:0] address[7:0];
	wire [2:0] buildingColour[7:0];
	
	buildingOne b1(address[0], clock, buildingColour[0]);
	buildingTwo b2(address[1], clock, buildingColour[1]);
	buildingThree b3(address[2], clock, buildingColour[2]);
	buildingFour b4(address[3], clock, buildingColour[3]);
	buildingFive b5(address[4], clock, buildingColour[4]);
	buildingSix b6(address[5], clock, buildingColour[5]);
	buildingSeven b7(address[6], clock, buildingColour[6]);
	buildingEight b8(address[7], clock, buildingColour[7]);
	
	always@(posedge clock)begin
		if(drawSelection && black)begin
			colour <= 'b111;
			start <= 1;
		end
		else if(drawSelection)begin
			//140x17
			xi <= 3;
			yi <= 36 * (selectedAsset + 1);
			colour <= 'b010;
			start <= 1;
		end
		else if(drawUpgrade)begin
			//75x75
			if(selectedAsset % 2 == 0)begin
				xi <= 150;
				yi <= 5;
			end
			else begin
				xi <= 230;
				yi <= 80;
			end
			start <= 1;
		end
		else if(drawMoney)begin
			xi <= 3;
			yi <= 230;
			start <= 1;
		end
		else 
			start <= 0;
	
	//end
	
	//always@(posedge clock)begin
		
		plot <= 0;
		
		case(currentStep)
		
			0: begin
					if(start && drawSelection)
						nextStep <= 1;
					else if(start && drawUpgrade)
						nextStep <= 6;
					else if(start && drawMoney)
						nextStep <= 10;
					else
						nextStep <= 0;
				end
			1:	begin
					plot <= 1;
					nextStep <= 2;
					x <= xi;
					y <= yi;
				end
			2:	begin
					if(x < xi+ 140)begin
						x <= x + 1;
						plot <= 1;
					end
					else begin
						x <= xi;
						nextStep <= 3;
					end
					
				end
			3:	begin
					if(y < yi + 17)begin
						y <= y + 1;
						plot <= 1;
					end
					else begin
						nextStep <= 4;
					end
				end
			4:	begin
					if(x < xi + 140)begin
						x <= x + 1;
						plot <= 1;
					end
					else begin
						y <= yi;
						nextStep <= 5;
					end
				end
			5:	begin
					if(y < yi + 17)begin
						y <= y + 1;
						plot <= 1;
					end
					else begin
						nextStep <= 0;
						y <= yi;
						x <= xi;
					end
				end
			6: begin
					x <= xi;
					y <= yi;
					address[selectedAsset] <= 0;
					colour <= buildingColour[selectedAsset];
					plot <= 1;
					count <= 1;
				end
			7: begin
					if(x < xi + 75)begin
						x <= x + 1;
						address[selectedAsset] <= address[selectedAsset] + 1;
						plot <= 1;
						nextStep <= 7;
						colour <= buildingColour[selectedAsset];
					end
					else begin
						x <= xi;
						nextStep <= 8;
					end
				end
			8: begin
					if(y < yi + count)begin
						y <= y + 1;
						address[selectedAsset] <= address[selectedAsset] + 1;
						plot <= 1;
						nextStep <= 9;
						colour <= buildingColour[selectedAsset];
					end
					else if(y < yi + 75)begin
						nextStep <= 9;
						count <= count + 1;
					end
					else
						nextStep <= 0;
				end
			default: nextStep <= 0;
		
		endcase
		
		
		
	end
	
	always@(posedge clock)begin
		
		currentStep <= nextStep;
		
	end

endmodule
