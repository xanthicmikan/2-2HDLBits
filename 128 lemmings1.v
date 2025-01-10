module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;
  
    //step 1 轉移條件
    always @(*) begin
        // State transition logic
		case(state)
		    LEFT : next_state = (bump_left) ? RIGHT:LEFT;
			RIGHT : next_state = (bump_right) ? LEFT:RIGHT;
		endcase
    end

    //step 2 狀態轉移
    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
		state <= (areset) ? LEFT : next_state;
    end

    // Output logic
	// step 3 輸出
	//組合邏輯
    //assign walk_left = (state == LEFT);
    //assign walk_right = (state == RIGHT);
    //時序邏輯
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end
        else if (next_state==LEFT) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end
        else begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
        end
    end




endmodule