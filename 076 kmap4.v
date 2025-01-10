module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
/*	
method 1:
assign out =((~c&~d)&(~a&b|a&~b))|
     ((~c&d)&(~a&~b|a&b))|
     ((c&d)&(~a&b|a&~b))|
     ((c&~d)&(~a&~b|a&b));
method 2:
    assign out = 
        (~a & b & ~c & ~d)| 
        (a & ~b & ~c & ~d)|
        (~a & ~b & ~c & d)|
        (a & b & ~c & d)| 
        (~a & b & c & d)|
        (a & ~b & c & d)|
        (~a & ~b & c & ~d)|
        (a & b & c & ~d);
*/
//method 3:	
    assign out = a^b^c^d;
endmodule