module top_module ( input a, input b, output out );
    //By position
    mod_a obj(a, b, out);
    //By name
    //mod_a obj( .in(a), .in(b), .out(out));
endmodule

//note:
//By position
//mod_a instance1 ( wa, wb, wc );
//By name
//mod_a instance2 ( .out(wc), .in1(wa), .in2(wb) );