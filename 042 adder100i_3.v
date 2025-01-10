module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    genvar i;
    generate
        for(i = 0; i<$bits(sum); i++) 
        begin:gen
             add adder(
             .cin((i==0)?cin:cout[i-1]),
             .a(a[i]),
             .b(b[i]),
             .cout(cout[i]),
             .sum(sum[i])
    );
        end
    endgenerate

endmodule

module add(
    input cin,
    input a,
    input b,
    output sum,
    output cout
);
    assign {cout,sum}=cin+a+b;
   
endmodule