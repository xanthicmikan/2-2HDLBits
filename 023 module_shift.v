module top_module ( input clk, input d, output q );
    
	// Create two wires. I called them a and b.
    wire a, b;
	// Create three instances of my_dff, with three different instance names (d1, d2, and d3).
	// Connect ports by position: ( input clk, input d, output q)	
    my_dff d1( .clk(clk), .d(d), .q(a));
    my_dff d2( .clk(clk), .d(a), .q(b));
    my_dff d3( .clk(clk), .d(b), .q(q));
    
endmodule