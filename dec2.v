module decimalDecoder(SW,HEX0,HEX1, HEX2);
	input [7:0]SW;
	input [6:0]HEX0;
	input [6:0]HEX1;
	input [6:0]HEX2;
	wire [11:0] q;
	
	binaryToBCD B1 (.binaryIn(SW[7:0]),.BCD(q[11:0]));
	
	hex_decoder H0 (.hex_digit(q[3:0]),.segments(HEX0[6:0]));
	hex_decoder H1 (.hex_digit(q[7:4]),.segments(HEX1[6:0]));
	hex_decoder H2 (.hex_digit(q[11:8]),.segments(HEX2[6:0]));
endmodule

module binaryToBCD(
    binaryIn,
	HundredBillions,
	TenBillions,
	Billions,
	HundredMillions,
	TenMillions,
	Millions,
	HundredThousands,
	TenThousands,
	Thousands,
	Hundreds,
	Tens,
	Ones
    );

    
    //input ports and their sizes
    input [30:0] binaryIn;
    //output ports and, their size
    output reg[3:0] Ones;
	output reg[3:0] Tens;
	output reg[3:0] Hundreds;
	output reg[3:0] Thousands;
	output reg[3:0] TenThousands;
	output reg[3:0] HundredThousands;
	output reg[3:0] Millions;
	output reg[3:0] TenMillions;
	output reg[3:0] HundredMillions;
	output reg[3:0] Billions;
	output reg[3:0] TenBillions;
	output reg[3:0] HundredBillions;
    //Internal variables
    //reg [11 : 0] BCD; 
    integer [31:0] i;   
     
     always @(binaryIn)
        begin
            HundredBillions = 4'd0;
			TenBillions= 4'd0;
			Billions= 4'd0;
			HundredMillions= 4'd0;
			TenMillions= 4'd0;
			Millions= 4'd0;
			HundredThousands= 4'd0;
			TenThousands= 4'd0;
			Thousands= 4'd0;
			Hundreds= 4'd0;
			Tens= 4'd0;
			Ones= 4'd0;
            for (i = 0; i < 31; i = i+1) //run for 8 iterations
            begin
				//add 3 if greater than 5
				if(HundredBillions>=5)
					HundredBillions = HundredBillions +3;
				if(TenBillions >= 5)
					TenBillions = TenBillions +3;
				if(Billions>=5)
					Billions = Billions +3;
				if(HundredMillions>=5)
					HundredMillions	= HundredMillions +3;
				if(TenMillions>=5)
					TenMillions = TenMillions +3;
				if(Millions>=5)
					Millions = Millions +3;
				if(HundredThousands>=5)
					HundredThousands = HundredThousands +3;
				if(TenThousands>=5)
					TenThousands = TenThousands +3;
				if(Thousands>=5)
					Thousands = Thousands +3;
				if(Hundreds>=5)
					Hundreds = Hundreds +3;
				if(Tens>=5)
					Tens = Tens +3;
				if(Ones>=5)
					Ones = Ones +3;
				
				//Shifting
				HundredBillions = HundredBillions<<1;
				HundredBillions[0] = TenBillions[3];
				TenBillions = TenBillions<<1;
				TenBillions[0] = Billions[3];
				Billions = Billions<<1;
				Billions[0] = HundredMillions[3];
				HundredMillions = HundredMillions<<1;
				HundredMillions[0] = TenMillions[3];
				TenMillions = TenMillions<<1;
				TenMillions[0] = Millions[3];
				Millions = Millions<<1;
				Millions[0] = HundredThousands[3];
				HundredThousands = HundredThousands<<1;
				HundredThousands[0] = TenThousands[3];
				TenThousands = TenThousands<<1;
				TenThousands[0] = Thousands[3];
				Thousands = Thousands<<1;
				Thousands[0] = Hundreds[3];
				Hundreds = Hundreds<<1;
				Hundreds[0] = Tens[3];
				Tens = Tens<<1;
				Tens[0] = Ones[3];
				Ones = Ones<<1;
				Ones[0] = binaryIn[i];
            end
        end     
                
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule