module top_module (input x, input y, output z);

    wire z1, z2;
    A IA(.x(x), .y(y), .z(z1));
    B IB(.x(x), .y(y), .z(z2));
    
    assign z = (z1|z2)^(z1&z2);
    
endmodule

module A (input x, input y, output z);
    assign z= (x^y) & x ;
endmodule

module B ( input x, input y, output z );
    //XNOR gate
    assign z = ~(x ^ y);
endmodule