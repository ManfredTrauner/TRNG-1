/*
 Gate NAND 2 Input Testbench
*/

`default_nettype none
`timescale 1ns/1ps
`include "gate_NAND_01.v"

module gate_NAND_01_tb;
// Define parameters

  //parameter DELAY = 10; // Delay for stimulus
  
  // Declare signals
  reg A, B;   // Input signals
  wire Y;     // Output signal


    gate_NAND_01 dut(.A(A),.B(B),.Y(Y));

  // Stimulus generation
  initial begin
    // Test case 1: A=0, B=0
    A = 0;
    B = 0;
    $display("A=%b, B=%b, Y=%b", A, B, Y);
    
    // Test case 2: A=0, B=1
    A = 0;
    B = 1;
    $display("A=%b, B=%b, Y=%b", A, B, Y);
    
    // Test case 3: A=1, B=0
    A = 1;
    B = 0;
    $display("A=%b, B=%b, Y=%b", A, B, Y);
    
    // Test case 4: A=1, B=1
    A = 1;
    B = 1;
    $display("A=%b, B=%b, Y=%b", A, B, Y);
    
    // End simulation
    $finish;
  end


 endmodule // 


 `default_nettype wire 
