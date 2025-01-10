module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 
 
    // assign s = ...
    // assign overflow = ...
    assign s = a + b;
    assign overflow = (~s[7] & a[7] & b[7]) | (s[7] & ~a[7] & ~b[7]);
    // two positive numbers produces a negative result
    // e.g (bin)0101+0100 = 1001 = -1(dec) 
    // two negative numbers produces a positive result
    // e.g (bin)1100+1010 = 0110 = 6(dec) 
    // s = a + b; 
    // overflow =~(a[7]^b[7]) & (s[7] == a[7] ? 0:1);
endmodule