module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 

    wire [3:0] w1, w10, w100;
     
    assign c_enable = {
        w1==9 && w10==9,
        w1==9,
        1'b1
    };
    assign OneHertz = w1==9 && w10==9 && w100==9;
    bcdcount counter0 (clk, reset, c_enable[0], w1);
    bcdcount counter1 (clk, reset, c_enable[1], w10);
    bcdcount counter2 (clk, reset, c_enable[2], w100);   

endmodule