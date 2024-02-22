`default_nettype none
`timescale 1ns/1ns
`include "rs_ff_01.v"


module rs_ff_01_tb;

wire R;
wire S;
reg clk = 0;
reg clk1 = 0;
reg clk2 = 0;
wire Q;

// Instantiate D flip-flop
rs_ff_01 dut (
    .R(R),
    .S(S),
    .Q(Q)
);


// Clock generation
always #1 clk = ~clk; // Invert clk every 5 time units4
always #4 clk1 = ~clk1;
always #5 clk2 = ~clk2;
assign R = clk1;
assign S = clk2;
//always #4 D = ~ D;
//always #4 I1 = ~ I1;

// Apply data input and observe output
initial begin
 $dumpfile ("rs_ff_01_tb.vcd") ;
 $dumpvars ;
 #150   
 $finish;
end

endmodule

`default_nettype wire 
 
