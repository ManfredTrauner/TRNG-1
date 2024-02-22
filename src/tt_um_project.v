/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

/* verilator lint_off DECLFiLENAME */

`define default_netname none
`include "mscell_01s.v"

module tt_um_project (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out[0] = ena;
  assign uio_out[1] = clk;
  assign uio_out[2] = rst_n;
  assign uio_out[7:3] = 0;
  assign uio_oe  = 0;

mscell_01 entUnit01 (.clk_entropy(clk),
                     .clk_sampling(clk),
                     .en_Samp_in0(0),
                     .en_Samp_in1(0),
                     .en_Samp_out(0),
                     .Y(Y)); 

assign uio_out[3] = Y;

endmodule

/* verlator Lint_on DECLFILENMAME */



