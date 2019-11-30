module binaryToBCD(
    binaryIn,
	Millions,
	HundredThousands,
	TenThousands,
	Thousands,
	Hundreds,
	Tens,
	Ones
    );

    
    //input ports and their sizes
    input [39:0] binaryIn;
    //output ports and, their size
    output reg[3:0] Ones;
	output reg[3:0] Tens;
	output reg[3:0] Hundreds;
	output reg[3:0] Thousands;
	output reg[3:0] TenThousands;
	output reg[3:0] HundredThousands;
	output reg[3:0] Millions;
    //Internal variables
    //reg [11 : 0] BCD; 
    integer i;   
     
     always @(binaryIn)
        begin
			Millions= 4'd0;
			HundredThousands= 4'd0;
			TenThousands= 4'd0;
			Thousands= 4'd0;
			Hundreds= 4'd0;
			Tens= 4'd0;
			Ones= 4'd0;
            for (i = 21; i >=0; i = i-1) //run for 8 iterations
            begin
				//add 3 if greater than 5
			
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