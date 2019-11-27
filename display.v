module display
    (
        CLOCK_50,                        //    On Board 50 MHz
		  KEY,
		  SW,
        // The ports below are for the VGA output.  Do not change.
        VGA_CLK,                           //    VGA Clock
        VGA_HS,                            //    VGA H_SYNC
        VGA_VS,                            //    VGA V_SYNC
        VGA_BLANK_N,                        //    VGA BLANK
        VGA_SYNC_N,                        //    VGA SYNC
        VGA_R,                           //    VGA Red[9:0]
        VGA_G,                             //    VGA Green[9:0]
        VGA_B                           //    VGA Blue[9:0]
    );

    input            CLOCK_50;                //    50 MHz   
	 input [9:0] SW;
	 assign reset = SW[0];
	 input [1:0] KEY;
    // Declare your inputs and outputs here
    // Do not change the following outputs
    output            VGA_CLK;                   //    VGA Clock
    output            VGA_HS;                    //    VGA H_SYNC
    output            VGA_VS;                    //    VGA V_SYNC
    output            VGA_BLANK_N;                //    VGA BLANK
    output            VGA_SYNC_N;                //    VGA SYNC
    output    [7:0]    VGA_R;                   //    VGA Red[7:0] Changed from 10 to 8-bit DAC
    output    [7:0]    VGA_G;                     //    VGA Green[7:0]
    output    [7:0]    VGA_B;                   //    VGA Blue[7:0]
   
    wire [2:0] colour;
    wire [8:0] x;
    wire [8:0] y;
    //wire go;
    //reg writeEn;
	
	//assign writeEn = SW[0];
	
    wire [2:0] DataColour;
	 wire [2:0] colourNumber;
	wire writeEn;
	 //assign colour = colourNumber;
	 
    // Create an Instance of a VGA controller - there can be only one!
    // Define the number of colours as well as the initial background
    // image file (.MIF) for the controller.
    vga_adapter VGA(
            .resetn(!SW[0]),
            .clock(CLOCK_50),
            .colour(colourNumber),
            .x(x),
            .y(y),
            .plot(writeEn),
            /* Signals for the DAC to drive the monitor. */
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
        defparam VGA.BACKGROUND_IMAGE = "black.mif";
            
    // Put your code here. Your code should produce signals x,y,colour and writeEn
    // for the VGA controller, in addition to any other functionality your design may require.
     wire [11:0] numberAddress;
	 ///wire [3:0] outputROM;
	 //memory
	 
	 numberNew N1 (.address(numberAddress),.clock(CLOCK_50),.q(colourNumber));
	 drawNumbers D1 (.reset(SW[0]),.clock(CLOCK_50),.initialX(9'd300),.initialY(9'd208),.writeEn(writeEn),.xCounter(x),.yCounter(y),.picAddress(numberAddress));
	 
endmodule

module drawNumbers(reset, clock, writeEn, initialX, initialY, xCounter, yCounter, picAddress);
	//parameter WIDTH = 20;
	//parameter HEIGHT = 32;
	
	input clock;
	input reset;
	output reg writeEn;
	input [8:0] initialX;
	input [8:0] initialY;
	reg [8:0] outputX;
	reg [8:0] outputY;
	output reg [11:0] picAddress;
	
	output reg [8:0] xCounter;
	output reg [8:0] yCounter;
	
	always@(posedge clock)begin
		if (reset) begin
			outputX<=8'b0;
			outputY<=8'b0;
			xCounter<=9'b0;
			yCounter<=9'b0;
			picAddress<=9'b0;
			writeEn <= 1'b0;
		end
		else begin
			writeEn <= 1'b1;
			//picAddress <= yCounter * 20 + xCounter;
			if (picAddress <= 20'd638) begin
				if (xCounter < 5'd20) begin
					outputX <= xCounter + initialX;
					xCounter <= xCounter + 1'b1;
					picAddress <= picAddress + 1'b1;
				end
				else begin
					xCounter <= 6'b0;
					//outputY <= outputY + 1;
					if (yCounter < 6'b100000)begin
						yCounter <= yCounter +1'b1;
						outputY<=  initialY + outputY;
						picAddress<= picAddress + 1'b1;

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
