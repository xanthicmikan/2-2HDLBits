module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0],data};
        end
        else begin
            q <= (count_ena) ? q-1:q;
        end
    end

endmodule