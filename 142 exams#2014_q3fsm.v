module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A=1'b0, B=1'b1;
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = s ? B:A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        state <= (reset) ? A:next_state ;
    end
    
    // counter
    reg [1:0] cnt_cycle, cnt_w;
    always @(posedge clk) begin
        if (reset) begin
            cnt_cycle <= 2'b00;
        end
        else if (state==B) begin //state B 後每三輪一輸出
            if (cnt_cycle==2'b10) begin
                cnt_cycle <= 2'b00;
            end
            else begin
                cnt_cycle <= cnt_cycle + 1;
            end
        end
        else begin
            cnt_cycle <= 2'b00;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt_w <= 2'b00;
        end
        else if (state==B) begin
            if (cnt_cycle==2'b00) begin // 第一筆
                cnt_w <= (w) ? 1:0; //復位時起始從1or0
            end
            else begin
                cnt_w <= cnt_w + w;
            end
        end
        else begin //state A 空閒狀態
            cnt_w <= 2'b00;
        end
    end
    
    // Output logic
    assign z = (state==B) & (cnt_cycle==0) & (cnt_w==2);
    
endmodule