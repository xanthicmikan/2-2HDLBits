module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    wire out;
	
	//clock
	initial clk = 0;
	always #5 clk = ~clk;
	
    //in
    initial begin
        in = 0;
        #20 in = 1; //20
        #10 in = 0; //30
        #10 in = 1; //40
        #30 in = 0; //70
    end
    
    //s
    initial begin
        s = 3'd2;
        #10 s = 3'd6; //10
        #10 s = 3'd2; //20
        #10 s = 3'd7; //30
        #10 s = 3'd0; //40
    end
    
    q7 q(clk, in, s, out);

endmodule
