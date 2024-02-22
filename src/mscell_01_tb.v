`default_nettype none
`timescale 1ns/1ns
`include "mscell_01.v"


module mscell_01_tb;

reg clk_entropy = 0;
reg clk_sampling = 0;
reg en_Samp_in0 = 0;
reg en_Samp_in1 = 0;
reg en_Samp_out = 0;
wire Y;

// Instantiate mscell_01
mscell_01 dut (
    .clk_entropy(clk_entropy),
    .clk_sampling(clk_sampling),
    .en_Samp_in0(en_Samp_in0),
    .en_Samp_in1(en_Samp_in1),
    .en_Samp_out(en_Samp_out),
    .Y(Y)
);

// Clock generation
/* verilator lint_off STMTDLY */
always #1 clk_sampling = ~ clk_sampling;
always #4 clk_entropy  = ~ clk_entropy;
/* verilator lint_on STMTDLY */


// Apply data input and observe output
initial begin
 $dumpfile ("mscell_01_tb.vcd") ;
 $dumpvars ;
 /* verilator lint_off STMTDLY */
 #150   
 /* verilator lint_on STMTDLY */
 $finish;
end

endmodule

`default_nettype wire 
 
