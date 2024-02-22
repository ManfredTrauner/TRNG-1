
`default_nettype none
`timescale 1ns/1ns
`include "mux_2to1.v"

module mux_2to1_tb;

// inputs
 reg I0 = 0;
 reg I1 = 1'b1;
 reg Select = 0;
 wire Y;

mux_2to1 uut (
    .I0(I0),
    .I1(I1),
    .Select(Select),
    .Y(Y)
);

/* verilator lint_off STMTDLY */
 always #20 Select = ~ Select ;
 always #2 I0 = ~ I0;
 always #4 I1 = ~ I1;
 /* verilator lint_on STMTDLY */

initial begin
    //$timeformat (-9, 3, "ns", 6); // Set time format to -9 (picoseconds) with 3 decimal places, and "ns" as the time unit
/*
    // Test case 1: Sel=0, I0=1, I1=0
    //Select = 0;
    I0 = 1;
    I1 = 0;
    //#10; // Wait for some time
    // Wait for some time
    repeat(10) @(posedge $time);
    $display("Y=%b", Y);

    // Test case 2: Sel=1, I0=0, I1=1
    //Select = 1;
    I0 = 0;
    I1 = 1;
    #10; // Wait for some time
    $display("Y=%b", Y);
    
    // End simulation
*/

 $dumpfile ("mux_2to1_tb.vcd") ;
 $dumpvars ;

 /* verilator lint_off STMTDLY */
 //#10 I0 = 1'b0 ;
 // I0 = 0;
 // I1 = 1;
 //#10 I1 = 1'b1 ;
 #100 $finish; // finish
 
/* verilator lint_on STMTDLY */

   
end

endmodule

 `default_nettype wire
  