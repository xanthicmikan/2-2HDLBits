module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    always@(posedge clk) begin
        if(load)
            q <= data;
        else begin
			//     left           right
			//  neighbour       neighbour
			//q <= q[511:1] ^ {q[510:0], 1'b0} ;		
            q <= (q<<1)^(q>>1);
        end
    end
	
/*
    wire [511:0] left,right;
    assign left = {1'b0,q[511:1]}; //assign left = (q>>1);
    assign right = {q[510:0],1'b0}; //assign right = (q<<1);
    
    always @(posedge clk) begin
        q <= (load) ? data : left^right;
    end
*/	
endmodule