module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT=0, RIGHT=1,groundL=2,groundR=3,DIG_L=4,DIG_R=5,SPLAT=6;
    reg [2:0]state, next_state;
    reg [7:0]cnt;
    always@(posedge clk , posedge areset)
    begin
        if(areset)
            cnt <= 'd0;
        else if((state == groundL)||(state == groundR))
            cnt <= (cnt>=20)?cnt:cnt+1'b1;
        else
            cnt <= 'd0;
    end

    always @(*) begin
        // State transition logic
        case(state)
            LEFT:next_state=ground?(dig?DIG_L:(bump_left?RIGHT:LEFT)):groundL;
            RIGHT:next_state=ground?(dig?DIG_R:(bump_right?LEFT:RIGHT)):groundR;
            groundL:next_state=ground?((cnt==20)?SPLAT:LEFT):groundL;
            groundR:next_state=ground?((cnt==20)?SPLAT:RIGHT):groundR;
            DIG_L:next_state=ground?DIG_L:groundL;
            DIG_R:next_state=ground?DIG_R:groundR;
            SPLAT:next_state=SPLAT;
            default:next_state='dx;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == groundL)||(state == groundR);
    assign digging = (state == DIG_L)||(state == DIG_R);
endmodule