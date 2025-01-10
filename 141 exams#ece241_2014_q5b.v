//Serial two’s complementer (Mealy FSM)
//從兩個時序圖可以發現，因為Mealy output 是隨 input 馬上變化的，
//因此會比 Moore Machine 快一個 clk 。
module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter S0=1'b0, S1=1'b1;
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = x ? S1:S0;
            S1: next_state = S1;
            default: next_state = S0;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk, posedge areset) begin
        state <= (areset) ? S0:next_state ;
    end
    
    // Output logic
    assign z = (state==S0 && x==1)||(state==S1 && x==0);

endmodule