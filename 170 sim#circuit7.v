module top_module (
    input clk,
    input a,
    output q );

    always @(posedge clk) begin
        q <= (~a) ? 1:0;
    end    
    
endmodule
