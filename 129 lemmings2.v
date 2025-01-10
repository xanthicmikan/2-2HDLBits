module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT=2'b00, RIGHT=2'b01, groundL=2'b10, groundR=2'b11;
    reg [1:0] state, next_state;
    
    // State transition logic
    // step 1 轉移條件
    always @(*) begin
        // State transition logic
        case(state)
            LEFT:next_state=ground?(bump_left?RIGHT:LEFT):groundL;
            RIGHT:next_state=ground?(bump_right?LEFT:RIGHT):groundR;
            groundL:next_state=ground?LEFT:groundL;
            groundR:next_state=ground?RIGHT:groundR;
        endcase
    end
    // State flip-flops with asynchronous reset
    // step 2 狀態轉移
    always @(posedge clk, posedge areset) begin
        state <= (areset) ? LEFT:next_state ;
    end
    // Output logic
    // step 3 輸出
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == groundL)||(state == groundR);
	/*
	always @(posedge clk, posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end
        else begin
            case (next_state)
                LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                end
                RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                end
                groundL: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
                groundR: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
                default: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                end
            endcase
        end //else
    end //always
	*/
	
endmodule