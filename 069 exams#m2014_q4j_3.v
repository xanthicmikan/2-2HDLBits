module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire [3:0]cout;
    full_adder fa[3:0](x, y, {cout[2:0] ,1'b0}, {sum[4], cout[2:0]}, sum[3:0]);
    
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );

    assign {cout, sum} = a + b + cin;
  
endmodule