`timescale		1 ns/1 ps		// Display things in ns, compute them in ps
`define HalfCycle	18.518			// This is in ns (see above)
`define Cycle		(`HalfCycle * 2)	// Didn't you learn to multiply?

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:49:29 03/08/2008
// Design Name:   Timer
// Module Name:   c:/users/cs150-hx/Checkpoint01/TimerTestBench.v
// Project Name:  Checkpoint01
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TimerTestBench_v;

	// Inputs
	reg Clock;
	reg [31:0] In;

	// Outputs
	wire Out;

	// Instantiate the Unit Under Test (UUT)
	Timer uut (
		.Clock(Clock), 
		.In(In), 
		.Out(Out)
	);
	
	always #(`HalfCycle) Clock =	~Clock;

	initial begin
		// Initialize Inputs
		Clock = 0;
		In = 0;
		//always #(`HalfCycle) Clock =	~Clock;	

		#(`Cycle);
		#(`Cycle);
		In = 3;
		#(`Cycle*4);
		In = 5;
		
        
		// Add stimulus here

	end
      
endmodule

