module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
    
    assign c_enable = enable;
    assign c_load = reset | ((Q == 4'd12) && enable == 1'b1);
    assign c_d = 4'd1;
    count4 the_counter (
        .clk    (clk      ), //input
        .enable (c_enable ), //input
        .load   (c_load   ), //input
        .d      (c_d      ), //input
        .Q      (Q        )  //output
    );

endmodule