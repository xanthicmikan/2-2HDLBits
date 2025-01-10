module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    reg [6:1] next_state;
    assign next_state = {
        y[4]&~w,
        y[3]&~w | y[5]&~w,
        y[2]&w | y[3]&w | y[5]&w | y[6]&w,
        y[2]&~w | y[6]&~w,
        y[1]&~w,
        y[1]&w | y[4]&w
    };
    assign Y2 = next_state[2];
    assign Y4 = next_state[4];
	
endmodule