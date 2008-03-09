`timescale 1ns / 1ps
// This is a black box.  DO NOT CHANGE THIS FILE!
module Checkpoint0bb(   Clock,
                        Reset,

                        RAMReadRequest,
                        RAMWriteRequest,
                        RAMMask,
                        RAMReadAddress,
                        RAMDataToWrite,

                        RAMReady,
                        RAMDataValid,
                        RAMDone,

                        OutputEnable,
                        CountWriteBurstAddress,
                        SelectReadAddress,

                        FIFOReadRequest,

                        FIFODataCount,
                        FIFOReadData,

                        Mode,
                        ErrorCount,
                        CP0Input,
                        CP0Output
                        ); /* synthesis syn_black_box */

    input               Clock;
    input               Reset;

    output              RAMReadRequest;
    output              RAMWriteRequest;
    output              RAMMask;
    output reg  [23:0]  RAMReadAddress;
    output reg  [31:0]  RAMDataToWrite;

    input               RAMReady;
    input               RAMDataValid;
    input               RAMDone;

    output              OutputEnable;
    output              CountWriteBurstAddress;
    output              SelectReadAddress;

    output              FIFOReadRequest;

    input       [1:0]   FIFODataCount;
    input       [31:0]  FIFOReadData;

    input       [1:0]   Mode;

    output      [31:0]  ErrorCount;
    input               CP0Input;
    output      [31:0]  CP0Output;

    // This is a black box.  DO NOT CHANGE THIS FILE!

endmodule
