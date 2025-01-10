module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;
    
	//step1:條件轉移
    always @(*) begin
        // State transition logic
		case (state)
		OFF: next_state = (j==1'b1)? ON:OFF;
		ON: next_state = (k==1'b1)? OFF:ON;
		endcase
    end
	//step2:狀態轉移
    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
		state <=(areset)? OFF:next_state;
    end

    // Output logic
    // assign out = (state == ...);
    always @(posedge clk, posedge areset) begin
        if (areset)
            out <= 1'b0;
        else if (next_state==OFF)
            out <= 1'b0;
        else
            out <= 1'b1;
    end
endmodule