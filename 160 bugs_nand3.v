module top_module (input a, input b, input c, output out);//

    wire w;//error 1
    andgate inst1 (
        .out(w),
        .a(a),
        .b(b),
        .c(c),
        .d(1),
        .e(1)
    );//error 2
 
    assign out = ~w;//error 1
endmodule
