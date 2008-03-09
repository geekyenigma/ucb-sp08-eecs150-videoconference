`timescale 1ns / 1ps
module SDRAMControl(Clock,
                    Reset,
                    Ready,
                    Done,
                    DataValid,
                    ReadRequest,
                    WriteRequest,
                    OutputEnable,
                    WriteData,
                    Address,
                    Mask,
                    RAM_CLK,
                    RAM_CLKE,
                    RAM_DQMH,
                    RAM_DQML,
                    RAM_CS_,
                    RAM_RAS_,
                    RAM_CAS_,
                    RAM_WE_,
                    RAM_BA,
                    RAM_A,
                    RAM_DQ,
						  CurrentState);

    input           Clock;
    input           Reset;

    output reg      Ready;
    output reg      Done;
    output reg      DataValid;

    input           ReadRequest;
    input           WriteRequest;
    input           OutputEnable;

    input   [31:0]  WriteData;
    input   [23:0]  Address;
    input           Mask;

    output             RAM_CLK;
    output             RAM_CLKE;
    output reg         RAM_DQMH;
    output reg         RAM_DQML;
    output reg         RAM_CS_;
    output reg         RAM_RAS_;
    output reg         RAM_CAS_;
    output reg         RAM_WE_;
    output reg [1:0]   RAM_BA;
    output reg [12:0]  RAM_A;

    inout   [31:0]  RAM_DQ;
	
    // TEMP OUTPUTS
    output reg [4:0] CurrentState;	
	
    //---------------------------------------------------------------
    //	Wires and Regs
    //---------------------------------------------------------------
    wire    [12:0]  RowAddr;
    wire    [1:0]   BankAddr;
    wire    [8:0]   ColAddr;
	 
	 reg     [31:0]  TimerIN;
    wire            TimerRSLT;
    //---------------------------------------------------------------
	 
    //---------------------------------------------------------------
    //	Assigns
    //---------------------------------------------------------------
    assign {RowAddr, BankAddr, ColAddr} = Address;
	
    assign RAM_CLK = ~Clock;
    assign RAM_CLKE = 1'b1;
    //---------------------------------------------------------------
	
    //---------------------------------------------------------------
    //	Tri-State Buffer
    //---------------------------------------------------------------
    assign RAM_DQ = OutputEnable ? WriteData : 32'bz;
    //---------------------------------------------------------------

    //---------------------------------------------------------------
    //	Parameters
    //---------------------------------------------------------------
	 parameter 	INITIAL =		5'b00000,
					PRECHARGE =		5'b00001,
					RFC1 =			5'b00010,
					REFRESH1 =		5'b00011,
					REFRESH2 =		5'b00100,
					IDLE =			5'b00101,
					RACTIVE =		5'b00110,
					READCOL =		5'b00111,
					CASWAIT =		5'b01000,
					READSTATE =		5'b01001,
					WACTIVE =		5'b01011,
					WRITECOL =		5'b01100,
					WRITESTATE =	5'b01101,
					WRITEWAIT =		5'b01110,
					INITIAL1 =		5'b11111,
					RFC2 =			5'b11110,
					LOADMODE =		5'b11101,
					Com_NOP				=	4'b0111,
					Com_PRECHARGE		=	4'b0010,
					Com_AUTOREFRESH	=	4'b0001,
					Com_LOADMODEREG	=	4'b0000,
					Com_ACTIVE			=  4'b0011,
					Com_READ				=	4'b0101,
					Com_WRITE			=	4'b0010;
    //---------------------------------------------------------------
	
    //---------------------------------------------------------------
    //	Count-down Timer
    //---------------------------------------------------------------
	 Timer myTimer(  .Clock(Clock),   .In(TimerIN),
                    .Out(TimerRSLT)               );	 
    //---------------------------------------------------------------


	always @(posedge Clock) begin
		if (Reset) begin
			CurrentState <= INITIAL;
			TimerIN = 32'd2800;
			{Ready, Done, DataValid} = 3'b0;
			{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
		end else begin
			case (CurrentState)
				//INITIAL1: begin
				//	CurrentState = INITIAL;
				//	{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				//end
				INITIAL: begin
					if (TimerRSLT) begin
						CurrentState = PRECHARGE;
					end
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
				PRECHARGE: begin
					CurrentState = REFRESH1;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_PRECHARGE;
				end
				REFRESH1: begin
					TimerIN = 32'd215;
					CurrentState = RFC1;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_AUTOREFRESH;				
				end
				RFC1: begin
					if (TimerRSLT) begin
						TimerIN = 0;
						CurrentState = REFRESH2;
					end
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;					
				end
				REFRESH2: begin
					TimerIN = 32'd215;
					CurrentState = RFC2;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_AUTOREFRESH;				
				end
				RFC2: begin
					if (TimerRSLT) begin
						TimerIN = 0;
						CurrentState = LOADMODE;
					end
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;					
				end
				LOADMODE: begin
					CurrentState = IDLE;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_LOADMODEREG;
				end
				IDLE: begin
					if (ReadRequest) begin
						CurrentState = RACTIVE;
					end else if (WriteRequest) begin
						CurrentState = WACTIVE;
					end
					Ready = 1'b1;
					DataValid = 1'b0;
					Done = 1'b0;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
				RACTIVE: begin
					CurrentState = READCOL;
					Ready = 1'b0;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_ACTIVE;
					RAM_A = RowAddr;
					RAM_BA = BankAddr;
					RAM_DQML = 1'b0;
					RAM_DQMH = 1'b0;
				end
				READCOL: begin
					CurrentState = CASWAIT;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_READ;
					RAM_A = {4'b0, ColAddr};
					RAM_BA = BankAddr;
				end
				CASWAIT: begin
					CurrentState = READSTATE;
					TimerIN = 32'd8;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
				READSTATE: begin
					if (TimerRSLT) begin
						CurrentState = IDLE;
						Done = 1'b1;
					end
					DataValid = 1'b1;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
				WACTIVE: begin
					CurrentState = WRITECOL;
					Ready = 1'b0;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_ACTIVE;
					RAM_A = RowAddr;
					RAM_BA = BankAddr;
					RAM_DQML = 1'b0;
					RAM_DQMH = 1'b0;
				end
				WRITECOL: begin
					CurrentState = WRITESTATE;
					TimerIN = 32'd7;
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_WRITE;
					RAM_A = {4'b0010, ColAddr};
					RAM_BA = BankAddr;
				end
				WRITESTATE: begin
					if (TimerRSLT) begin
						CurrentState = WRITEWAIT;
						TimerIN = 32'd2;
					end
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
				WRITEWAIT: begin
					if (TimerRSLT) begin
						CurrentState = IDLE;
					end
					{RAM_CS_, RAM_RAS_, RAM_CAS_, RAM_WE_} = Com_NOP;
				end
			endcase
		end
	end
	
endmodule
