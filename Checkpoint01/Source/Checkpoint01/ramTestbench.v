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
module ramTestbench;
	//---------------------------------------------------------------
	//	Wires and Regs
	//---------------------------------------------------------------
	reg			Clock, Reset;



	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	CUT:	Lab2Top
	//---------------------------------------------------------------
	wire Ready, Done;
	wire DataValid;
	reg ReadRequest, WriteRequest, OutputEnable;
	reg [31:0] WriteData;
	reg [23:0] Address;
	reg Mask;
	wire DQMH, DQML, CS, RAS, CAS, WE; 
	wire [1:0]  BA;
	wire [12:0] A; 
	wire [31:0] DQ;
		wire CLK, CLKE;
		wire [4:0] State;
//		wire [31:0] counted;
//		wire cReset, cEnable;


	SDRAMControl		CUT(	.Clock(			Clock),
									.Reset(			Reset),
									.Ready(			Ready),
									.Done(			Done),
									.DataValid(		DataValid),
									.ReadRequest(	ReadRequest),
									.WriteRequest(	WriteRequest),
									.OutputEnable(	OutputEnable),
									.WriteData(		WriteData),
									.Address(		Address),
									.Mask(			Mask),
									.RAM_CLK(		CLK),
									.RAM_CLKE(		CLKE),
									.RAM_DQMH(		DQMH),
									.RAM_DQML(		DQML),
									.RAM_CS_(		CS),
									.RAM_RAS_(		RAS),
									.RAM_CAS_(		CAS),
									.RAM_WE_(		WE),
									.RAM_BA(			BA),
									.RAM_A(			A),
									.RAM_DQ(			DQ),
									.CurrentState(	State));
									//.counted(		counted),
									//.countReset(	cReset),
									//.countEnable(	cEnable));
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
		#(`Cycle*10);
		Reset = 1'b1;
					ReadRequest = 1'b0;
			WriteRequest = 1'b0;
			OutputEnable = 1'b0;
			WriteData = 32'h00000000;
			Address = 24'h000000;
			Mask = 1'b0;
		#(`Cycle);	
		Reset = 1'b0;
		#(`Cycle*10000);
		WriteRequest = 1'b1;
		
		
		// Add more test cases here!!
	end
	//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------