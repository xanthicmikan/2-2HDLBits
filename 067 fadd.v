module top_module( 
    input a, b, cin,
    output cout, sum );

    assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (a&cin) | (b&cin);
	
	//method2
	//assign {cout, sum} = a + b + cin;
endmodule




