module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5;
    reg [3:1] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (y)
            A: next_state = w ? A:B;
            B: next_state = w ? D:C;
            C: next_state = w ? D:E;
            D: next_state = w ? A:F;
            E: next_state = w ? D:E;
            F: next_state = w ? D:C;
            default: next_state = A;
        endcase
    end
    
    /*
    // State flip-flops (sequential)
    always @(posedge clk) begin
        state <= (reset) ? A:next_state ;
    end
    */
    
    // Output logic
    assign Y2 = next_state[2];
    
endmodule
