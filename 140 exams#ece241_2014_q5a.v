//Serial two’s complementer (Moore FSM)
module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    //output left-shift, S0:same(just start), S1(1)<->S2(0)
    parameter S0=2'b00, S1=2'b01, S2=2'b10;
    reg [1:0] state, next_state;
	
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = x ? S1:S0;
            S1: next_state = x ? S2:S1;
            S2: next_state = x ? S2:S1;
            default: next_state = S0;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk, posedge areset) begin
        state <= (areset) ? S0:next_state ;
    end
    
    // Output logic
    assign z = (state==S1);	

endmodule
