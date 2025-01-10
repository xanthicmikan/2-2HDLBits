module top_module (
    input clk,
    input reset,
    output [9:0] q);

    always @(posedge clk) begin
        q <= (q==10'd999 || reset) ? 10'd0 : q+1 ;
    end
    
endmodule