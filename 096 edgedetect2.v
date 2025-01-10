module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] in_reg;
    always @(posedge clk) begin
    	in_reg <= in;//in_reg 跟 in 差一個clk
        anyedge <= in ^ in_reg;//in為1 in_reg為0 或 in為0 in_reg為1
    end
    
endmodule
