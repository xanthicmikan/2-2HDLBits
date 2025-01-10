//a 拉 High 後輸出數值固定為 4，平時則為計數器，最高值為 6。
module top_module (
    input clk,
    input a,
    output [3:0] q );

    always @(posedge clk) begin
        if (a) begin
            q <= 4'd4;
        end
        else begin
            q <= (q==4'd6) ? 0:q+1;
        end
    end
endmodule