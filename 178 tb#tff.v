module top_module ();
 reg clk,rst,t;
    wire q;
    
    //clock
    initial clk = 0;
    always #5 clk = ~clk;
    
    //reset
    initial begin
        rst = 1;
        #10 rst = 0;
    end
    
    //Toggle
    initial begin
        t = 0;
        #10 t = 1;
    end
    
    tff tff1(clk, rst, t, q);
endmodule