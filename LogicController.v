`timescale 1ns / 1ns

module logicController(clock, received_data, received_data_en, click, buy, one, two, three, four, five, six, seven, eight, selection, upgradeClick);

	input clock, received_data_en;
	input [7:0]received_data;
	output reg click, buy, one, two, three, four, five, six, seven, eight, selection, upgradeClick;
	
	localparam IDLE = 0, CLICK = 1, BUY = 2, ONE = 3, TWO = 4, THREE = 5, FOUR = 6, FIVE = 7, SIX = 8, SEVEN = 9, EIGHT = 10, UPGRADECLICK = 11;
	
	reg [4:0] currentState = IDLE;
	reg [4:0] nextState;
	
	always@(*)begin
	
		case(currentState)
		
			IDLE:	begin
						if(received_data_en)begin
							if(received_data == 'h29)
								nextState = CLICK;
							else if(received_data == 'h5A)
								nextState = BUY;
							else if(received_data == 'h16)
								nextState = ONE;
							else if(received_data == 'h1E)
								nextState = TWO;
							else if(received_data == 'h26)
								nextState = THREE;
							else if(received_data == 'h25)
								nextState = FOUR;
							else if(received_data == 'h2E)
								nextState = FIVE;
							else if(received_data == 'h36)
								nextState = SIX;
							else if(received_data == 'h3D)
								nextState = SEVEN;
							else if(received_data == 'h3E)
								nextState = EIGHT;
							else if(received_data == 'h21)
								nextState = UPGRADECLICK;
							else
								nextState = IDLE;
						end
						else
							nextState = IDLE;
					end		
			CLICK: nextState = IDLE;
			BUY: nextState = IDLE;
			ONE: nextState = IDLE;
			TWO: nextState = IDLE;
			THREE: nextState = IDLE;
			FOUR: nextState = IDLE;
			FIVE: nextState = IDLE;
			SIX: nextState = IDLE;
			SEVEN: nextState = IDLE;
			EIGHT: nextState = IDLE;
			UPGRADECLICK: nextState = IDLE;
			default: nextState = IDLE;
		
		endcase
						
	
	end
	
	always@(*)begin
	
		click = 0;
		buy = 0; 
		one = 0; 
		two = 0; 
		three = 0; 
		four = 0; 
		five = 0; 
		six = 0; 
		seven = 0; 
		eight = 0;
		selection = 0;
		upgradeClick = 0;
		
		case(currentState)
		
			CLICK: click = 1;
			BUY: buy = 1;
			ONE:	begin
						one = 1;
						selection = 1;
					end
			TWO:	begin
						two = 1;
						selection = 1;
					end
			THREE:begin
						three = 1;
						selection = 1;
					end
			FOUR:	begin
						four = 1;
						selection = 1;
					end
			FIVE: begin
						five = 1;
						selection = 1;
					end
			SIX:	begin
						six = 1;
						selection = 1;
					end
			SEVEN:begin 
						seven = 1;
						selection = 1;
					end
			EIGHT:begin 
						eight = 1;
						selection = 1;
					end
			UPGRADECLICK: upgradeClick = 1;
			
			default: begin
				click = 0;
				buy = 0; 
				one = 0; 
				two = 0; 
				three = 0; 
				four = 0; 
				five = 0; 
				six = 0; 
				seven = 0; 
				eight = 0;
				selection = 0;
				upgradeClick = 0;
			end
		
		endcase
	
	end
	
	always@(posedge clock)begin
			
		currentState <= nextState;
			
	end

endmodule