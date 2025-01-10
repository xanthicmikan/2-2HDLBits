module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [4:0] carry;
    assign carry[0] = cin;
    
    bcd_fadd obj[3:0] (a, b, carry[3:0], carry[4:1], sum);
    assign cout = carry[4]; 
    
endmodule
//method 2
/*
module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire [2:0]c;
    bcd_fadd add[3:0](a[15:0],b[15:0],{c[2:0],cin},{cout,c[2:0]},sum[15:0]);
endmodule
*/