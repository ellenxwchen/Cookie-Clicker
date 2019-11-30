`timescale 1ns / 1ns

module logicDatapath(clock, pulse, money, prev_data, selectedAsset, click, buy, upgradeClick, one, two, three, four, five, six, seven, eight);

	input clock, pulse, click, buy, upgradeClick, one, two, three, four, five, six, seven, eight;
	input[7:0] prev_data;
	output reg [39:0] money = 10;
	
	localparam ONE = 0, TWO = 1, THREE = 2, FOUR = 3, FIVE = 4, SIX = 5, SEVEN = 6, EIGHT = 7, BREAK = 'hF0;
	
	output reg [7:0] selectedAsset = ONE;
	reg[29:0] rate = 0; 
	reg[29:0] clickRate = 1;
	reg[29:0] clickRateCost = 10;
	reg[23:0] assetCost[7:0];
	reg[23:0] assetRates[7:0];
	reg reset = 1;
	
	wire enoughMoney = (money>= assetCost[selectedAsset]);
	wire enoughMoneyClick = (money >= clickRateCost);
	
	always@(*)begin
	
		if(reset)begin
			assetCost[ONE] = 10;
			assetCost[TWO] = 40;
			assetCost[THREE] = 250;
			assetCost[FOUR] = 2000;
			assetCost[FIVE] = 10000;
			assetCost[SIX] = 100000;
			assetCost[SEVEN] = 1000000;
			assetCost[EIGHT] = 10000000;
			
			assetRates[ONE] = 1;
			assetRates[TWO] = 5;
			assetRates[THREE] = 15;
			assetRates[FOUR] = 60;
			assetRates[FIVE] = 800;
			assetRates[SIX] = 10000;
			assetRates[SEVEN] = 50000;
			assetRates[EIGHT] = 500000;
			
			reset = 0;
		end
	
	end
	always@(posedge clock)begin
	
		if(prev_data == BREAK)
			selectedAsset <= selectedAsset;
		else if(one)
			selectedAsset <= ONE;
		else if(two)
			selectedAsset <= TWO;
		else if(three)
			selectedAsset <= THREE;
		else if(four)
			selectedAsset <= FOUR;
		else if(five)
			selectedAsset <= FIVE;
		else if(six)
			selectedAsset <= SIX;
		else if(seven)
			selectedAsset <= SEVEN;
		else if(eight)
			selectedAsset <= EIGHT;
		else 
			selectedAsset <= selectedAsset;
	
	end
	
	always@(posedge clock)begin
	
		if(prev_data == BREAK)
			money <= money;
		else if(click)
			money <= money + clickRate;
		else if(buy && enoughMoney)
			money <= money - assetCost[selectedAsset];
		else if(upgradeClick && enoughMoneyClick)
			money <= money - clickRateCost;
		else if(pulse)
			money <= money + rate;
		else
			money <= money;
	end
	
	always@(posedge clock)begin
	
		if(prev_data == BREAK)
			rate <= rate;
		else if(buy && enoughMoney)
			rate <= rate + assetRates[selectedAsset];
		else
			rate <= rate;
	end
	
	always@(posedge clock)begin
	
		if(prev_data == BREAK)begin
			clickRate <= clickRate;
			clickRateCost <= clickRateCost;
		end
		else if(upgradeClick && enoughMoneyClick)begin
			clickRate <= clickRate * 2;
			clickRateCost <= clickRateCost * 2;
		end
		else begin 
			clickRate <= clickRate;
			clickRateCost <= clickRateCost;
		end
	end
	

endmodule