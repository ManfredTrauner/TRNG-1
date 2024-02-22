
module freq_div(
    input clk,         // Input clock
    input [7:0] divisor, // 8-bit divisor register
    output reg out      
);

reg [7:0] counter; 

always @(posedge clk) begin
    if (counter == divisor) begin
        out <= ~out; // Toggle output every time counter reaches the divisor
        counter <= 0; // Reset counter
    end else begin
        counter <= counter + 1; // Increment counter
    end
end

endmodule