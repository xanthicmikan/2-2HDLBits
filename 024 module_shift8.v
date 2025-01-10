module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    reg [7:0] a, b, c;
    my_dff8 d1(.clk(clk),.d(d),.q(a));
    my_dff8 d2(.clk(clk),.d(a),.q(b));
    my_dff8 d3(.clk(clk),.d(b),.q(c));
    
    //4to1 mux
    assign q=(sel[1] ? (sel[0] ? c:b) : (sel[0] ? a:d));
     
	// This is one way to make a 4-to-1 multiplexer
	//always @(*)		// Combinational always block
		//case(sel)
			//2'h0: q = d;
			//2'h1: q = o1;
			//2'h2: q = o2;
			//2'h3: q = o3;
		//endcase	
endmodule