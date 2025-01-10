// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    // step 1 轉移條件
    always @(*) begin
        case (state)
            B: next_state = (in==1'b1) ? B:A;
            A: next_state = (in==1'b1) ? A:B;
        endcase
    end

    // step 2 狀態轉移
    always @(posedge clk) begin
        state <= (reset) ? B:next_state ;
    end

    // step 3 輸出; 建議用時序邏輯, 用組合邏輯容易產生毛刺
    always @(posedge clk) begin
        if (reset)
            out <= 1'b1;
        else if (next_state==B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end
endmodule