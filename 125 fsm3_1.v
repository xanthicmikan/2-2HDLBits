module top_module(
    input clk,
    input in,
    input areset,
    output out); //

     parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
	 reg [1:0] state, next_state;
    // State transition logic
	// Step 1 轉移條件
	always @(*) begin
	   case(state)
	    A: next_state = (in) ? B : A;
		B: next_state = (in) ? B : C;
		C: next_state = (in) ? D : A;
		D: next_state = (in) ? B : C; 
	   endcase
    end
    // State flip-flops with asynchronous reset
	// Step 2 狀態轉移
    always @(posedge clk, posedge areset) begin
	    state <= (areset) ? A:next_state;
	end

    // Output logic
    // step 3 輸出; 建議用時序邏輯, 用組合邏輯容易產生毛刺
    always @(posedge clk, posedge areset) begin
        if (areset)
            out <= 1'b0;
        else if (next_state==D)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
