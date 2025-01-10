module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
	
	parameter S0=0,S1=1,S11=2,S110=3,S1101=4;
	reg[2:0]state,next_state;
	
	// State flip-flops (sequential)
	always @(posedge clk) begin
        state <= (reset) ? S0:next_state ;
    end
   
    // State transition logic (combinational)
    always@(*)
    begin
        case(state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S11 : S0;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? S1101 : S0;
            S1101: next_state = S1101;
            default: next_state = S0;
        endcase
    end
	
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end
        else begin
            start_shifting <= (next_state==S1101 & data) ? 1:start_shifting;
        end
    end
	//method 2
    //assign start_shifting=(state == S1101);

endmodule