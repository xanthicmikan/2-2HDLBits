module top_module (
    input [5:0] y,
    input w,
    output Y1,//y[1]
    output Y3//y[3]
);
    
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5; //one-hot
    assign Y1 = y[A] & w;
    assign Y3 = (y[B] & ~w) | (y[C] & ~w) | (y[E] & ~w) | (y[F] & ~w);
	
   // assign Y1 = (w == 1) && (y & 'b1);
   // assign Y3 = (w == 0) && (y & 'b110110);
endmodule