module top_module (
    input clk,
    input d,
    output q
);
/*//glitch
    reg q_temp1, q_temp2;
    always @(posedge clk) begin
        q_temp1 <= d;
    end
    
    always @(negedge clk) begin
        q_temp2 <= d;
    end
    
    assign q = (clk) ? q_temp1:q_temp2; //glitch    
 */  
  //better
	reg p, n;
	
	// A positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;
        
    // A negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p;
    
    // Why does this work? 
    // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
    // At each (positive or negative) clock edge, p and n FFs alternately
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;    
endmodule