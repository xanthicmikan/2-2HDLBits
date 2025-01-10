module top_module ( input x, input y, output z );

    //XNOR gate
    assign z = ~(x ^ y);
    
endmodule