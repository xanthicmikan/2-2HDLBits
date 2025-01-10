module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        q <= (reset || q == 4'd10) ? 1'b1 : q+1'b1;
    end    
    
endmodule