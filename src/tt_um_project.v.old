/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

/* verilator lint_off DECLFiLENAME */

`define default_netname none
//`include "mscell_01s.v"

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
  assign uio_out[7:4] = 0;
  assign uio_oe  = 0;

/*
mscell_01 entUnit01 (.clk_entropy(clk),
                     .clk_sampling(clk),
                     .en_Samp_in0(0),
                     .en_Samp_in1(0),
                     .en_Samp_out(0),
                     .Y(Y)); 

assign uio_out[3] = Y;
*/

/*
wire Q;
wire Q_n;
wire R;
wire S;
assign R = clk;
assign S = clk;

RS_ff cel1 (.Q(Q), .Q_n(Q_n), .R(R), .S(S));

assign uio_out[3] = Q;
assign uio_out[4] = Q_n;

*/
wire rout;
ring_osc3 osc (.clk(clk), .out(rout));
assign uio_out[3] = rout;

endmodule


module ring_osc3 (
    input wire clk,
    output reg out
);

reg [2:0] stages; // Register to hold the state of each stage
wire feedback;    // Feedback signal from the last stage to the first

assign feedback = stages[2]; // Connect the output of the last stage to the first stage input

// Instantiate three inverters (you can adjust the number of stages as needed)
// Each stage is a D flip-flop with its input connected to the output of the previous stage
always @(posedge clk) begin
    stages <= {stages[1:0], feedback}; // Shift the stages and feed the feedback to the first stage
end

assign out = stages[2]; // Output the state of the last stage

endmodule



`default_nettype wire
/* verlator Lint_on DECLFILENMAME */

