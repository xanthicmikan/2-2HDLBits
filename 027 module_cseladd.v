module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire cout1, nouse1, nouse2;
    wire [15:0]sum_hi_0, sum_hi_1;
    add16 o0(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(cout1));
    add16 o1(.a(a[31:16]),.b(b[31:16]),.cin(1'b0), .sum(sum_hi_0), .cout(nouse1));
    add16 o2(.a(a[31:16]),.b(b[31:16]),.cin(1'b1), .sum(sum_hi_1), .cout(nouse2));

    assign sum[31:16] = cout1 ? sum_hi_1 : sum_hi_0;    
    
endmodule