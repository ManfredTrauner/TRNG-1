/*
 D_FF
 (without Reset))
*/

`default_nettype none

module D_FF(
    input D,     // Data input
    input clk,   // Clock input
    output reg Q // Output
);

always @(posedge clk) begin
    Q <= D; // Update Q with D on positive edge of clock
end

endmodule

`default_nettype wire 


