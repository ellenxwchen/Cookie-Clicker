`timescale 1ns / 1ns

module graphicsController(clock, pulse, selection, buy, drawSelection, drawUpgrade, drawMoney, black);

	input clock, pulse, selection, buy;
	
	output reg drawSelection, drawUpgrade, drawMoney, black;
	
	reg [2:0]currentState, nextState, prevState;
	
	localparam IDLE = 0, MONEY = 1, SELECTION = 2, UPGRADE = 3, BLACK = 4;
	
	always@(*)begin
	
		case(currentState)
		
			IDLE:
				begin
					if(buy && pulse)
						nextState = UPGRADE;
					else if(selection && pulse)
						nextState = BLACK;
					else if(pulse)
						nextState = MONEY;
					else 
						nextState = IDLE;
				end
			MONEY:	nextState = IDLE;
	
			SELECTION:	nextState = IDLE;
			
			UPGRADE:	nextState = IDLE;
			BLACK:	nextState = SELECTION;
			default: nextState = IDLE;
		
		endcase
	
	end
	
	always@(*)begin
	
		drawMoney = 0;
		drawSelection = 0;
		drawUpgrade = 0;
		black = 0;
		
		case(currentState)
		
			IDLE:	
				begin
					drawMoney = 0;
					drawSelection = 0;
					drawUpgrade = 0;
				end
			MONEY:
				begin
					drawMoney = 1;
					drawSelection = 0;
					drawUpgrade = 0;
				end
			SELECTION:
				begin
					drawMoney = 0;
					drawSelection = 1;
					drawUpgrade = 0;
				end
			UPGRADE:
				begin
					drawMoney = 0;
					drawSelection = 0;
					drawUpgrade = 1;
				end
			BLACK: 	begin
						black = 1;
						drawSelection = 1;
						end
			default:
				begin
					drawMoney = 0;
					drawSelection = 0;
					drawUpgrade = 0;
					black = 0;
				end
		
		endcase
	
	end
	
	always@(posedge clock)begin
	
		currentState <= nextState;
		
	end
	

endmodule

