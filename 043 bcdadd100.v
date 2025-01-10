//Instantiate 100 copies of bcd_fadd to create a 100-digit BCD ripple-carry adder. 
module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [98:0]c;
    bcd_fadd u_bcd_fadd[99:0](
        .a(a[399:0]),
        .b(b[399:0]),
        .cin({c[98:0],cin}),
        .cout({cout,c[98:0]}),
        .sum(sum[399:0])
    );    
    
endmodule

//method 2
/*
module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    
    bcd_fadd obj[99:0] (a, b, carry[99:0], carry[100:1], sum);
    assign cout = carry[100];
    
endmodule
*/