//using k-map
module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    wire [511:0] left,right;
    assign left = {1'b0,q[511:1]}; //assign left = (q>>1);
    assign right = {q[510:0],1'b0}; //assign right = (q<<1);
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
		    //(~L&C)|(~R&C)|(R&~C)
            q <= (~left&q) | (q&~right) | (~q&right); //k-map
    end
    
endmodule