/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used             *
*     solely for design, simulation, implementation and creation of            *
*     design files limited to Xilinx devices or technologies. Use              *
*     with non-Xilinx devices or technologies is expressly prohibited          *
*     and immediately terminates your license.                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"            *
*     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                  *
*     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION          *
*     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION              *
*     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS                *
*     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                  *
*     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE         *
*     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY                 *
*     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                  *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          *
*     FOR A PARTICULAR PURPOSE.                                                *
*                                                                              *
*     Xilinx products are not intended for use in life support                 *
*     appliances, devices, or systems. Use in such applications are            *
*     expressly prohibited.                                                    *
*                                                                              *
*     (c) Copyright 1995-2003 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/
// The synopsys directives "translate_off/translate_on" specified below are
// supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity synthesis
// tools. Ensure they are correct for your synthesis tool(s).

// You must compile the wrapper file fifo_sync32d.v when simulating
// the core, fifo_sync32d. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Guide".

module fifo_sync32d (
	clk,
	sinit,
	din,
	wr_en,
	rd_en,
	dout,
	full,
	empty,
	data_count);    // synthesis syn_black_box

input clk;
input sinit;
input [31 : 0] din;
input wr_en;
input rd_en;
output [31 : 0] dout;
output full;
output empty;
output [1 : 0] data_count;

// synopsys translate_off

	SYNC_FIFO_V4_0 #(
		2,	// c_dcount_width
		0,	// c_enable_rlocs
		1,	// c_has_dcount
		0,	// c_has_rd_ack
		0,	// c_has_rd_err
		0,	// c_has_wr_ack
		0,	// c_has_wr_err
		0,	// c_memory_type
		0,	// c_ports_differ
		1,	// c_rd_ack_low
		1,	// c_rd_err_low
		32,	// c_read_data_width
		32,	// c_read_depth
		32,	// c_write_data_width
		32,	// c_write_depth
		1,	// c_wr_ack_low
		1)	// c_wr_err_low
	inst (
		.CLK(clk),
		.SINIT(sinit),
		.DIN(din),
		.WR_EN(wr_en),
		.RD_EN(rd_en),
		.DOUT(dout),
		.FULL(full),
		.EMPTY(empty),
		.DATA_COUNT(data_count),
		.RD_ACK(),
		.WR_ACK(),
		.RD_ERR(),
		.WR_ERR());


// synopsys translate_on

endmodule

