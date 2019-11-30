`timescale 1ns / 1ns


module moneyClicker(SW,LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, CLOCK_50, PS2_CLK, PS2_DAT, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
	input [0:0] SW;
	input CLOCK_50;
	output [9:0]LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	inout PS2_CLK, PS2_DAT;
	output [7:0]VGA_R, VGA_G, VGA_B; 
	output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK;
	
	
	wire [7:0]received_data;
	wire received_data_en;
	
	PS2_Controller keyboard(
									.CLOCK_50(CLOCK_50),
									.reset(0),
									.PS2_CLK(PS2_CLK),
									.PS2_DAT(PS2_DAT),
									.received_data(received_data),
									.received_data_en(received_data_en));
									
	wire [2:0] colour;
	wire [8:0] x, y;
	wire plot;
	
	vga_adapter VGA(
			.resetn(1),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(plot),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "backgroundNew.mif";

	
	wire pulse;	
	wire [39:0]money;
	
	wire [3:0] Millions;
	wire [3:0] HundredThousands;
	wire [3:0] TenThousands;
	wire [3:0] Thousands;
	wire [3:0] Hundreds;
	wire [3:0] Tens;
	wire [3:0] Ones;
	
	wire click, buy, upgradeClick, one, two, three, four, five, six, seven, eight;
	wire [7:0] prev_data, selectedAsset;
	wire [29:0] rate, clickRate;
	wire selection;
	
	wire [26:0] q;
	reg [9:0] regreg;
	
	rateDiv R1 (.clock(CLOCK_50),.Q(q));
	wire enable = ~|q;
	assign LEDR[9:0] = regreg [9:0];
	always @(posedge CLOCK_50)begin
		if (SW[0])
			regreg <= 10'b0000000001;
		if (enable) begin
			regreg <= regreg << 1'b1;
		end
		if (regreg == 10'b10000000000)
			regreg <= 10'b000000001;
		end
	
	binaryToBCD convert (money[39:0], Millions[3:0], HundredThousands[3:0], TenThousands[3:0], Thousands[3:0], Hundreds[3:0], Tens[3:0], Ones[3:0]);
	
	hexDecoder H0(Ones[3:0], HEX0);
        
	hexDecoder H1(Tens[3:0], HEX1);
	
	hexDecoder H2(Hundreds[3:0], HEX2);
        
	hexDecoder H3(Thousands[3:0], HEX3);
	
	hexDecoder H4(TenThousands[3:0], HEX4);
        
	hexDecoder H5(HundredThousands[3:0], HEX5);
	
	rateDivider pulseGenerator(CLOCK_50, pulse);
	
	prevData prev(CLOCK_50, received_data_en, received_data, prev_data);
	
	logicController control(CLOCK_50, received_data, received_data_en, click, buy, one, two, three, four, five, six, seven, eight, selection, upgradeClick);
	
	logicDatapath datapath(CLOCK_50, pulse, money, prev_data, selectedAsset, click, buy, upgradeClick, one, two, three, four, five, six, seven, eight);
	
	wire drawSelection, drawUpgrade, drawMoney, black;
	
	graphicsNumber G1 (CLOCK_50, plot, Millions[3:0], HundredThousands[3:0], TenThousands[3:0], Thousands[3:0], Hundreds[3:0], Tens[3:0], Ones[3:0], x[8:0], y[8:0], colour[2:0]);
	
	//graphicsUpgrades G2 (CLOCK_50, plot, x, y,colour);
	
	//graphicsController graphicController(CLOCK_50, pulse, selection, buy, drawSelection, drawUpgrade, drawMoney, black);
		
	//graphicsDatapath graphicDatapath(CLOCK_50, pulse, money, selectedAsset, drawSelection, drawUpgrade, drawMoney, black, x, y, plot, colour);
	
endmodule

module rateDiv(clock, Q);
	input clock;
	output reg [26:0]Q;
	
	always @ (posedge clock) begin
			if (Q == 27'b0)
				Q<=27'd12444444; //2 Hz
			else
				Q<=Q-1;
			end
endmodule
