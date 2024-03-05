/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none


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
  //assign uio_out[1] = clk;
  assign uio_out[3] = rst_n;
  assign uio_out[7:4] = 0;
  assign uio_oe  = 8'b1111_1111;


wire w_outTempRand;
wire w_outTempEnable;
wire w_TempSimu;
assign w_TempSimu = 1'b0; //-> link to input


entUnit_noN #(32) main (
    .i_clk(clk),
    .i_resSyncCircuit_n(rst_n),
    .i_clkSimulation(w_TempSimu),
    .i_enSim(ui_in[0]),
    .o_random(w_outTempRand),
    .o_enChain(w_outTempEnable)
);
assign uio_out[1] = w_outTempRand;
assign uio_out[2] = w_outTempEnable;
endmodule


//---------------------------------

/*
 de-bias.v
*/

/* Interfaces of included Modules
module flipflop_D_clk_res (
    input wire i_clk,
    input wire i_res_n,
    input wire i_D,
    output reg o_Q
*/

/*
module deBias (
    input wire i_clk,
    input wire i_reset_n,
    input wire i_enSim,    
    input wire i_random,
    output wire o_random,
    output wire o_valid
);

wire w_outFF1;
wire w_outFF2;
wire w_outXOR;
wire w_outG3;
wire w_outG2;
wire w_outFF3;
wire w_outG4;

flipflop_D_clk_res FF_01 (.i_clk(i_clk), .i_res_n(i_reset_n), .i_D(i_random), .o_Q(w_outFF1));
flipflop_D_clk_res FF_02 (.i_clk(i_clk), .i_res_n(i_reset_n), .i_D(w_outFF1), .o_Q(w_outFF2));
assign w_outXOR = w_outFF1 ^ w_outFF2;
assign w_outG2 = ~ w_outFF3;
assign w_outG3 = i_enSim & w_outG2;
flipflop_D_clk_res FF_03 (.i_clk(i_clk), .i_res_n(i_reset_n), .i_D(w_outG3), .o_Q(w_outFF3));

assign o_random = w_outFF1;
assign w_outG4 = w_outXOR & w_outFF3;
assign o_valid = w_outG4;
endmodule
*/


/*
 entUnit_noN 
*/

/* Interfaces of included Modules
module entCell_noN #(
    parameter no_entCells = 3  
)(
    input wire i_clk,
    //input wire i_resAsyncCircuit_n,
    input wire i_resSyncCircuit_n,
    input i_random,
    input wire i_enSim,
    output wire o_random,
    output wire o_enChain
);

module gate_XOR_n #(parameter WIDTH = 3) (
    input wire [WIDTH-1:0] in,
    output wire out
);
*/

/* verilator lint_off DECLFILENAME */
module entUnit_noN #(
    parameter no_RingOsc = 3, 
    parameter switch_feedback = 1  //switch_feedback == 1: feedback-loop is closed for operation
                                   //switch_feedback == 0: for Simulation      
)(
    input wire i_clk,    
    input wire i_resSyncCircuit_n,

    /* verilator lint_off UNUSEDSIGNAL */
        input i_clkSimulation, //for simulation to input signal which can be view
    /* verilator lint_on UNUSEDSIGNAL */    

    input wire i_enSim,
    output wire o_random,
    output wire o_enChain
);

wire [no_RingOsc:0] w_enChain;
wire [no_RingOsc-1:0] w_outRand;
assign w_enChain[0] = i_enSim; 
genvar i;

generate
    for (i=0; i < no_RingOsc; i = i+1) begin : entUnit
    
           entCell_noN #(3+i*2, switch_feedback) entCell (
            .i_clk(i_clk),
            .i_resSyncCircuit_n(i_resSyncCircuit_n),
            .i_random(i_clkSimulation),
            .i_enSim(w_enChain[i]),
            .o_random(w_outRand[i]),
            .o_enChain(w_enChain[i+1])
            );
         
    end
endgenerate

wire w_outXOR;
gate_XOR_n #(no_RingOsc) gate01 (
    .in(w_outRand),
    .out(w_outXOR)
);

assign o_random = w_outXOR;
assign o_enChain = w_enChain[no_RingOsc];
endmodule
/* verilator lint_on DECLFILENAME */

/*
 entCell_noN 
*/

/* Interfaces of included Modules
module entCell_no1 (
    input wire i_clk,
    input wire i_resAsyncCircuit_n,
    input wire i_resSyncCircuit_n,
    input wire i_random,
    input wire i_enSim,
    output wire o_random,
    output wire o_enChain
);

module flipflop_D_clk_res (
    input wire i_clk,
    input wire i_res_n,
    input wire i_D,
    output reg o_Q
);
*/

/* verilator lint_off UNOPTFLAT */
// Ringoscillator produces "Signal unoptimizable: Circular combinatonal logic" via design

module entCell_noN #(
    parameter no_entCells = 3,  // cells no 0, 1 and 2 should be created
    parameter switch_feedback = 1  //switch_feedback == 1: feedback-loop is closed for operation
                                   //switch_feedback == 0: for Simulation
)(
    input wire i_clk,
    //input wire i_resAsyncCircuit,
    input wire i_resSyncCircuit_n,

    /* verilator lint_off UNUSEDSIGNAL */
        input i_random, //for simulation to input signal which can be view
    /* verilator lint_on UNUSEDSIGNAL */    

    input wire i_enSim,
    output wire o_random,
    output wire o_enChain
);

wire [no_entCells-1:0] w_outRand;
wire [no_entCells-1:0] w_outEnChain;
genvar i;

wire feedback; 
if(switch_feedback == 0 ) begin : initForSimulation
    assign feedback = i_random;
end
else begin: initForOperation
    assign feedback = w_outRand[no_entCells-1];
end

generate
    for (i=0; i < no_entCells; i = i+1) begin : gen_RingOsc
        //localparam int no_instCells = i; // Define local parameter for module instantiation
        
        if (i == 0) begin : gen_module_0// frist module
            entCell_no1 entCell (
            .i_clk(i_clk),
            .i_resAsyncCircuit_n(i_enSim),
            .i_resSyncCircuit_n(i_resSyncCircuit_n),
            //.i_random(w_outRand[no_entCells-1]),
            .i_random(feedback),
            .i_enSim(i_enSim),
            .o_random(w_outRand[i]),
            .o_enChain(w_outEnChain[i])
            );
        end
            
        else if (i == no_entCells-1) begin : gen_module_last // last module
            entCell_no1 entCell (
            .i_clk(i_clk),
            .i_resAsyncCircuit_n(i_enSim),
            .i_resSyncCircuit_n(i_resSyncCircuit_n),
            .i_random(w_outRand[i-1]), 
            .i_enSim(w_outEnChain[i-1]),
            .o_random(w_outRand[i]), 
            .o_enChain(w_outEnChain[i])
            );
        end
         
        else begin: gen_modules_middle //all modules between first and last
            entCell_no1 entCell (
            .i_clk(i_clk),
            .i_resAsyncCircuit_n(i_enSim),
            .i_resSyncCircuit_n(i_resSyncCircuit_n),
            .i_random(w_outRand[i-1]), 
            .i_enSim(w_outEnChain[i-1]),
            .o_random(w_outRand[i]),
            .o_enChain(w_outEnChain[i])
            );
        end
    end
endgenerate

// stabilizing output
wire w_between;
wire w_outStage;

flipflop_D_clk_res outStage1of2(
    .i_clk(i_clk),
    .i_res_n(i_resSyncCircuit_n),
    .i_D(w_outRand[no_entCells-1]),
    .o_Q(w_between)
    );

flipflop_D_clk_res outStage2of2 (
    .i_clk(i_clk),
    .i_res_n(i_resSyncCircuit_n),
    .i_D(w_between),
    .o_Q(w_outStage)
    );


//assign o_random = w_outRand[no_entCells-1];
assign o_random = w_outStage;
assign o_enChain = w_outEnChain[no_entCells-1];
endmodule
/* verilator lint_on UNOPTFLAT */ 


/*
 entCell_no1 
*/

/* Interfaces of included Modules
module gate_inv (
    input wire in,
    output wire out
);

module flipflop_D_clk_res (
    input wire i_clk,
    input wire i_res_n,
    input wire i_D,
    output reg o_Q

module flipflop_D_en_res (
    input wire D,
    input wire reset_n,
    input wire enable,
    output reg Q
);
*/

/* verilator lint_off UNOPTFLAT */
// Ringoscillator produces "Signal unoptimizable: Circular combinatonal logic" via design
// option UNOPTFLAT deactivates this warning


module entCell_no1 (
    input wire i_clk,
    input wire i_resAsyncCircuit_n,
    input wire i_resSyncCircuit_n,
    input wire i_random,
    input wire i_enSim,
    output wire o_random,
    output wire o_enChain
);

wire w_outInv;
wire w_enable;
wire w_outRand;

gate_inv Inv_01 (.in(i_random), .out(w_outInv));
flipflop_D_en_res FF_01 (.D(w_outInv), .reset_n(i_resAsyncCircuit_n), .enable(w_enable), .Q(w_outRand));
flipflop_D_clk_res FF_02 (.i_clk(i_clk), .i_res_n(i_resSyncCircuit_n), .i_D(i_enSim), .o_Q(w_enable));

assign o_enChain = w_enable;
assign o_random = w_outRand;
endmodule
/* verilator lint_on UNOPTFLAT */


module flipflop_D_clk_res (
    input wire i_clk,
    input wire i_res_n,
    input wire i_D,
    output reg o_Q
);

always @(posedge i_clk or negedge i_res_n) begin
    if (!i_res_n) begin
        o_Q <= 1'b0;    // Asynchronous reset
    end
    else begin
        o_Q <= i_D;     // D input on positive clock edge
    end
end
endmodule


module flipflop_D_en_res (
    input wire D,
    input wire reset_n,
    input wire enable,
    output reg Q
);


// Define the behavior of the D flip-flop
/* verilator lint_off LATCH */
always @* begin
    if (!reset_n) begin // Asynchronous reset
        Q = 1'b0;
    end else if (enable) begin // Enable signal
        Q = D;
    end
end
endmodule


module gate_XOR_n #(
    parameter width = 4
)(
    input wire [width-1:0] in, // Eingänge
    output reg out // Ausgang als Regsiter deklariert
);

integer i; // Loop variable declaration

always @* begin
    out = in[0]; // Initialisiere den Ausgang mit dem ersten Eingang

    for (i = 1; i < width; i = i + 1) begin : xor_loop
        out = out ^ in[i]; // XOR jedes Eingangs mit dem vorherigen Ergebnis
    end
end
endmodule


module gate_inv (
    input wire in,
    output wire out
);

assign out = ~in;
endmodule

`default_nettype wire 
 
