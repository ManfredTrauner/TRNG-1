/*
 RS FF
*/

`default_nettype none
`include "gate_NAND_01.v"

/* verilator lint_off UNOPTFLAT */
module rs_ff_01(input R,
 input S,
  output Q
  //output Q_n
  );

 /* 
  // Define signals
  wire nand_1_out, nand_2_out;
  
  // Implement RS flip-flop using NAND gates
 
 gate_NAND_01 u1 (.A(R), .B(nand_2_out), .Y(nand_1_out));
 gate_NAND_01 u2 (.A(S), .B(nand_1_out), .Y(nand_2_out));

  always @*
  begin
    assign Q = nand_1_out;
    assign Q_n = nand_2_out;   
  end
*/




/*
// Internal signals

wire nand_S, nand_R;

// Connect NAND gates

assign nand_S = ~(S & Q_n);
assign nand_R = ~(R & Q);
assign Q = nand_S;
assign Q_n = nand_R;


// Output Q and Q_bar
always @* begin
    Q = nand_S;
    Q_n = nand_R;
end
*/

// Define signals

 wire nand_1_out, nand_2_out;
 gate_NAND_01 u1 (.A(R), .B(nand_2_out), .Y(nand_1_out));
 gate_NAND_01 u2 (.A(S), .B(nand_1_out), .Y(nand_2_out));
 assign Q = nand_1_out;
 //assign Q_n = nand_2_out;


endmodule
/* verilator lint_on UNOPTFLAT */
 `default_nettype wire 
  
