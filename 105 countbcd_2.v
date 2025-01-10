module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg [3:0] w1, w10, w100, w1000; 
    always @(posedge clk) begin
        if (reset | w1==9)
            w1 <= 0;
        else
            w1 <= w1 + 1;
    end
    always @(posedge clk) begin
        if (reset | (w1==9&&w10==9) )
            w10 <= 0;
        else if (w1==9)
            w10 <= w10 + 1;
    end
    always @(posedge clk) begin
        if (reset | (w1==9&&w10==9&&w100==9) )
            w100 <= 0;
        else if (w1==9&&w10==9)
            w100 <= w100 + 1;
    end
    always @(posedge clk) begin
        if (reset | (w1==9&&w10==9&&w100==9&&w1000==9) )
            w1000 <= 0;
        else if (w1==9&&w10==9&&w100==9)
            w1000 <= w1000 + 1;
    end
    
    assign q = {w1000, w100, w10, w1};
    assign ena[1] = (w1==9)? 1:0;
    assign ena[2] = (w1==9&&w10==9)? 1:0;
    assign ena[3] = (w1==9&&w10==9&&w100==9)? 1:0;

endmodule