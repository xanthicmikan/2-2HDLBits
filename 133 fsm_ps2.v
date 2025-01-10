//實作 PS/2 傳輸介面。
//算是一種序列檢測，當 in[3] == 1 的時候開始序列，
//每經過 3 個 byte 輸出 done，
//但輸出 done 時必須 in[3] == 1，
//若 in[3] != 1 則丟棄 byte 直到下一次 in[3] == 1 發生。
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    //BYTE1=0,BYTE2=1,BYTE3=2,DONE=3;
    parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = in[3] ? S1:S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = in[3] ? S1:S0;
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
                S0: done<=0;
                S1: done<=0;
                S2: done<=0;
                S3: done<=1;
                default: done<=0;
            endcase
        end
    end
    
endmodule
