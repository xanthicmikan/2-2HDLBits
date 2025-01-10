module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101;
    reg [2:0] state, next_state;
    reg [3:0] cnt;
    reg [7:0] data;
    wire odd, rst;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = in ? S0:S1; //idle or start
            S1: next_state = S2; //data
            S2: next_state = (cnt==8) ? S3:S2; //cnt==8->check
            S3: next_state = in ? S4:S5; //stop or error
            S4: next_state = in ? S0:S1; //idle or start
            S5: next_state = in ? S0:S5; //idle or keep
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

    always @(posedge clk) begin
        if (reset) begin
            data <= 0;
        end
        else begin
            case (next_state)
                S1: data<=0;
                S2: data<={in,data[7:1]};
                default: data<=data;
            endcase
        end
    end

    assign rst = (reset) | (next_state==S1);
    parity parity_inst(
        .clk(clk),
        .reset(rst),
        .in(in),
        .odd(odd)
    );
    
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end
        else begin
            case (next_state)
                S4: done <= (odd);
                default: done <= 0;
            endcase
        end
    end
    //assign done = (state == S4) && (~odd); //odd reserve
    
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 0;
        end
        else begin
            case (next_state)
                S4: out_byte <= data;
                default: out_byte <= 0;
            endcase
        end
    end
    //assign out_byte = data;

endmodule