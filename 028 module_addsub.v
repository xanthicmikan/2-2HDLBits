module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire cout1, nouse;
    wire [31:0] bb;
    
    //assign bb = b ^ {32{sub}}; 
    //An XOR gate can also be viewed as a programmable inverter, where one input controls whether the other should be inverted.    
    //b[x]|sub|bb[x]
    // 0  | 0 | 0
    // 0  | 1 | 1
    // 1  | 0 | 1   
    // 1  | 1 | 0    
    assign bb = sub ? (~b) : b;	
    add16 o0(a[15:0], bb[15:0], sub, sum[15:0], cout1);
    add16 o1(a[31:16], bb[31:16], cout1, sum[31:16], nouse);
    
endmodule