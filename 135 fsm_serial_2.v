module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    //state : S0 idle; S1 start; S2 data; S3 stop; S4 error
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
    reg [2:0] state, next_state;
    reg [3:0] cnt;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = in ? S0:S1; //idle or start
            S1: next_state = S2; //data
            S2: next_state = (cnt==8) ? (in?S3:S4):S2; //cnt==8->S3orS4
            S3: next_state = in ? S0:S1; //idle or start
            S4: next_state = in ? S0:S4; //idle or keep
            default: next_state = S0;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        state <= (reset) ? S0:next_state ;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end
        else begin
            case (next_state)
                S3: done<=1;
                default: done<=0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt <= 0;
        end
        else begin
            case (next_state)
                S1: cnt<=0;
                S2: cnt<=cnt+1;
                default: cnt<=cnt;
            endcase
        end
    end
    
endmodule