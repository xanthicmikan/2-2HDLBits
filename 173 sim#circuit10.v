module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );

    always @(posedge clk) begin
        if (a == 1 && b == 1 && state == 0) state <= 1;
        if (a == 0 && b == 0 && state == 1) state <= 0;
    end
    assign q = a ^ b ^ state;
	
	/*
	//method 2
	assign q = a^b^state;
    always @(posedge clk) begin
        state <= (a==b) ? a:state; //慢一個clk
    end
	*/
	
endmodule