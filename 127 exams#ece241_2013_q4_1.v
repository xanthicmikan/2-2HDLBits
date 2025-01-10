module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    //mapping 0->S1 , S1->S2 . S2->S3 , >S3
    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3; 
    reg [1:0] state, next_state;
    
    // State transition logic
    // step 1 轉移條件
    always @(*) begin //狀態圖
        case (state)
            A: next_state = (s==3'b001) ? B:A;
            B: next_state = (s==3'b011) ? C:((s==3'b000) ? A:B);
            C: next_state = (s==3'b111) ? D:((s==3'b001) ? B:C);
            D: next_state = (s==3'b011) ? C:D;
        endcase
    end

    // State flip-flops with asynchronous reset
    // step 2 狀態轉移
    always @(posedge clk) begin
        state <= (reset) ? A:next_state ;
    end
    
    // Output logic
    // step 3 輸出; 建議用時序邏輯, 用組合邏輯容易產生毛刺
    always @(posedge clk) begin
        if (reset) begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b1;
            dfr <= 1'b1;
        end 
        else begin
            case (next_state)
                A: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b1;
                    dfr <= 1'b1;
                end
                B: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b0;
                    dfr <= (state==A) ? 0:((state==B) ? dfr:1); //水位(連續)下降或上升
                end
                C: begin
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= (state==B) ? 0:((state==C) ? dfr:1);
                end
                D: begin
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase
        end
    end
    
endmodule