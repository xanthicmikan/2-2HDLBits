// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    //wire
    assign out_assign = a ^ b;
    //combinational
    always @(*) begin 
        out_always_comb = a ^ b;
    end
    //combinational
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end
    
endmodule