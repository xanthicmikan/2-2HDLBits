// synthesis verilog_input_version verilog_2001
module top_module ( 
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);//

    always @(*) begin
        case (do_sub)
          0: out = a+b;
          1: out = a-b;
        endcase

        result_is_zero = (!out) ? 1:0 ; //error 1

        /*
        if (!out)
            result_is_zero = 1;
        else //error 1
            result_is_zero = 0;	//error 1
	    */
	
    end

endmodule