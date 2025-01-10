module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        q <= (reset || q == 4'd9) ? 0 : q+1'b1;
        /* //method 2
        if (reset)
            q <= 4'b0;
        else if (q==4'b1001) //4'd9
            q <= 4'b0;
        else
            q <= q + 1'b1;
        */
		
		/* //method3
		if (reset || q == 9)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
			q <= 0;
		else
			q <= q+1;
	    */
    end    
    
endmodule