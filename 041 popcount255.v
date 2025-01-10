module top_module( 
    input [254:0] in,
    output [7:0] out );

    //$size() gives the number of bits for a single dimension. 
    //$bits() gives the number of bits to completely represent the variable.
    always @(*) begin
        out = 8'b0;
        for(int i =0; i < $bits(in); i++) begin
            if(in[i]==1'b1)
             out = out+1'b1;
        end
    end
	
	//method2
	//always @(*) begin	// Combinational always block
		//out = 0;
		//for (int i=0;i<255;i++)
			//out = out + in[i];
	//end
	
    
endmodule