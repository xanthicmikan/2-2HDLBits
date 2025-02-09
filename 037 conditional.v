module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] min0, min1;
    // assign intermediate_result1 = compare? true: false;
    assign min0 = (a < b) ? a : b;
    assign min1 = (c < d) ? c : d;
    assign min = (min0 < min1) ? min0 : min1;

endmodule