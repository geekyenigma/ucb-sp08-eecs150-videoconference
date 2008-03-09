`timescale 1ns / 1ps
module AddressCounter(  Clock,
                        Reset,
                        AddressOut,
                        Count,
                        Bank,
								row,
								col);

    input               Clock;
    input               Reset;

    output      [23:0]  AddressOut;

    input               Count;
    input       [1:0]   Bank;


	output [12:0] row;
	output [8:0] col;
    // Start implementing here.
	
			
	 reg			[12:0]	row;
	 reg			[8:0]		col;
	 
	
	 always @(posedge Clock) begin
		if (Reset) begin
			row = 12'b000000000000;
			col = 9'b000000000;
		end
		else if (Count) begin
			if (col == 199) begin
				col = 9'b000000000;
				row = row+1;
			end
			else begin
				col = col+1;
			end
		end

	 end

endmodule