//-----------------------------------------------------------------------
//	File:		$RCSfile: Lab2Testbench.v,v $
//	Version:	$Revision: 1.2 $
//	Desc:		Lab2 Testbench
//	Author:		Greg Gibeling
//	Copyright:	Copyright 2003 UC Berkeley
//	This copyright header must appear in all derivative works.
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Section:	Change Log
//-----------------------------------------------------------------------
//	$Log: Lab2Testbench.v,v $
//	Revision 1.2  2004/07/08 18:39:51  Administrator
//	Added minor comments
//	
//	Revision 1.1  2004/07/07 23:23:34  Administrator
//	Initial Import
//	Fully Tested
//	Solution works
//	
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Section:	Defines and Constants
//-----------------------------------------------------------------------
`timescale		1 ns/1 ps		// Display things in ns, compute them in ps
`define HalfCycle	18.518			// This is in ns (see above)
`define Cycle		(`HalfCycle * 2)	// Didn't you learn to multiply?
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Module:		Lab2Testbench
//	CUT:		Lab2Top
//-----------------------------------------------------------------------
module addrCounterTestbench;
	//---------------------------------------------------------------
	//	Wires and Regs
	//---------------------------------------------------------------
	reg			Clock, Reset;



	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	CUT:	Lab2Top
	//---------------------------------------------------------------
	
	wire [23:0] AddressOut;
	reg Count;
	reg [1:0] Bank;
	wire [12:0] row;
	wire [8:0] col;

		
		AddressCounter		CUT(	.Clock(		Clock),
										.Reset(		Reset),
										.AddressOut(AddressOut),
										.Count(		Count),
										.Bank(		Bank),
										.row(			row),
										.col(			col));



	//---------------------------------------------------------------



	//---------------------------------------------------------------
	//	Clock Source
	//		This section will generate a clock signal,
	//		turning it on and off according the HalfCycle
	//		time, in this case it will generate a 27MHz clock
	//		THIS COULD NEVER BE SYNTHESIZED
	//---------------------------------------------------------------
	initial Clock =			1'b0;	// We need to start at 1'b0, otherwise clock will always be 1'bx
	always #(`HalfCycle) Clock =	~Clock;	// Every half clock cycle, invert the clock
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Test Stimulus
	//		This initial block will periodically set new
	//		values for the inputs to the CUT.
	//		THIS COULD NEVER BE SYNTHESIZED
	//---------------------------------------------------------------
	initial begin
		Bank = 2'b00;
		Reset = 1'b1;
		#(`Cycle);
		Reset = 1'b0;
		Count = 1'b1;
		
		// Add more test cases here!!
	end
	//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------