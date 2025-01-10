//p 會在 clock 拉 High 時隨 a 改變數值，當 clock 拉 Low 則保持數值。
//相對的 q 則是在 clock 下降沿對齊 p，與 a 無關。
module top_module (
    input clock,
    input a,
    output p,
    output q );
   
    always @(*) begin
        p = (clock) ? a : p;
    end
    
    always @(negedge clock) begin
        q <= p;
    end    

endmodule