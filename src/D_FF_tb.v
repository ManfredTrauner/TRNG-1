`default_nettype none
`timescale 1ns/1ns
`include "D_FF.v"


module D_FF_tb;

reg D = 0;
reg clk = 0;
wire Q;

// Instantiate D flip-flop
D_FF dut (
    .D(D),
    .clk(clk),
    .Q(Q)
);

// Clock generation
always #10 clk = ~clk; // Invert clk every 5 time units4
always #4 D = ~ D;
//always #4 I1 = ~ I1;

// Apply data input and observe output
initial begin
 $dumpfile ("D_FF_tb.vcd") ;
 $dumpvars ;
 #150   
 $finish;
end

endmodule

`default_nettype wire 
 
