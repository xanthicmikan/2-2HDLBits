//one-hot code
module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
	
	parameter S0=4'd0, S1=4'd1, S2=4'd2, S3=4'd3, S4=4'd4, S5=4'd5, S6=4'd6, S7=4'd7, S8=4'd8, S9=4'd9;
    
	//next state
    assign next_state[S0] = ~in&(state[S0]|state[S1]|state[S2]|state[S3]|state[S4]|state[S7]|state[S8]|state[S9]);
    assign next_state[S1] = (in&state[S0])|(in&state[S8])|(in&state[S9]);
    assign next_state[S2] = in&state[S1];
    assign next_state[S3] = in&state[S2];
    assign next_state[S4] = in&state[S3];
    assign next_state[S5] = in&state[S4];
    assign next_state[S6] = in&state[S5];
    assign next_state[S7] = (in&state[S6])|(in&state[S7]);
    assign next_state[S8] = ~in&state[S5];
    assign next_state[S9] = ~in&state[S6];
    
    //output
    assign out1 = state[S8]|state[S9];
    assign out2 = state[S7]|state[S9];	
	
	
/* //method 2
    always @(*) begin
        if (in)
            next_state <= (state[6:0] << 1) | state[7] << 7 | (state[9:8] ? 2 : 0);
        else
            next_state <= ({state[9:7], state[4:0]} ? 1 : 0) | state[6:5] << 8;
    end
    
    assign out1 = (state & 10'b1100000000) > 0;
    assign out2 = (state & 10'b1010000000) > 0;
*/	
	

endmodule