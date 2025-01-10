module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    add adder[99:0](
        .cin({cout[98:0],cin}),
        .a(a[99:0]),
        .b(b[99:0]),
        .cout(cout[99:0]),
        .sum(sum[99:0])
    );

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