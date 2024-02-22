/*
 Metastable state Cell with RS-FF
 TODOs
 Input Enable implementieren
*/

`default_nettype none

/* verilator lint_off MULTITOP */
`include "rs_ff_01.v"
`include "mux_2to1.v"
`include "D_FF.v"
/* verilator lint_on MULTITOP */

module mscell_01 (
    input clk_entropy,
    input clk_sampling,
    input en_Samp_in0,
    input en_Samp_in1,
    input en_Samp_out,
    output Y    
);

//wire nand_1_out, nand_2_out;
wire wire_FFin0_out, wire_FFin1_out;
wire wire_MUXin0_out, wire_MUXin1_out;
wire wire_FFent_out;
wire wire_FFout_out;
wire wire_MUXout_out;

 D_FF FFin0 (.D(clk_entropy), .clk(clk_sampling), .Q(wire_FFin0_out));   
 D_FF FFin1 (.D(clk_entropy), .clk(clk_sampling), .Q(wire_FFin1_out));  
  
 mux_2to1 MUXin0 (.I0(clk_entropy), .I1(wire_FFin0_out), .Select(en_Samp_in0), .Y(wire_MUXin0_out)); 
 mux_2to1 MUXin1 (.I0(clk_entropy), .I1(wire_FFin1_out), .Select(en_Samp_in1), .Y(wire_MUXin1_out)); 

 rs_ff_01 FFent (.R(wire_MUXin0_out), .S(wire_MUXin1_out), .Q(wire_FFent_out));

 D_FF FFout (.D(wire_FFent_out), .clk(clk_sampling), .Q(wire_FFout_out));  
 mux_2to1 MUXout (.I0(wire_FFent_out), .I1(wire_FFout_out), .Select(en_Samp_out), .Y(wire_MUXout_out));
 

 assign Y = wire_MUXout_out;

/*
 always @(posedge clk_samping) begin
        // no reset function
    end
*/

 endmodule // 


 `default_nettype wire 
