module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );

    assign out = sel ? b : a;
    

	// The following doesn't work. Why?
	// assign out = (sel & b) | (~sel & a);	
	//==>following below
	//wire [99:0] sel_1 = {100{sel}};
    //assign out = (sel_1 & b) | (~sel_1 & a);	
endmodule