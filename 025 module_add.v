module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1, nouse;
    
    add16 add_1(.a(a[15:0]), .b(b[15:0]), .cin(0), .cout(cout1), .sum(sum[15:0]) );
    add16 add_2(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .cout(nouse), .sum(sum[31:16]) );

endmodule