module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    parameter A=3'd1, B=3'd2, C=3'd3, D=3'd4, E=3'd5, F=3'd6; //one-hot
    
    assign Y2 = y[A] & ~w;
    assign Y4 = (y[B] & w) | (y[C] & w) | (y[E] & w) | (y[F] & w);
    
endmodule