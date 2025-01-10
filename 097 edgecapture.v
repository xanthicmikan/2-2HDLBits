module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] temp;
    always @(posedge clk) begin
        temp <= in;
        out <= (reset) ? 32'b0:((~in&temp)|out);//保存in下降沿的變化: 檢測下降沿並將輸出1,其餘保持不變
    end


endmodule