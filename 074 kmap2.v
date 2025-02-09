module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    assign out = (~a&~d)|(~c&~b)|(b&c&d)|(a&~b&d);
    
endmodule