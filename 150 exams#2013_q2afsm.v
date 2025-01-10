//仲裁電路(arbiter circuit)
//優先級 r1 > r2 > r3

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    reg [3:0] state, next_state;
    always @(*) begin
        case (state)
            'b0001: next_state <= (r[1] ? 'b0010: (r[2] ? 'b0100: (r[3] ? 'b1000: 'b0001)));
            'b0010: next_state <= r[1] ? 'b0010: 'b0001;
            'b0100: next_state <= r[2] ? 'b0100: 'b0001;
            'b1000: next_state <= r[3] ? 'b1000: 'b0001;
            default: next_state <= state;
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn)
            state <= 'b0001;
        else
            state <= next_state;
    end
    
	//B:g1, C:g2, D:g3
    assign g = state[3:1];
	//assign g = {(state==D),(state==C),(state==B)};
endmodule