module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output[7:0] out);//error 1
    
    assign out = ({8{sel}} & a) | ({8{~sel}} & b); //error 2
    //method 2
    //assign out = sel ? a : b;

endmodule