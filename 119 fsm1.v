//Note : FSM
//狀態的轉移條件 : 通常用 case 條列所有狀態的前後關係
//狀態的轉移動作 : 用時序邏輯描述狀態轉移與切入點
//輸出 : 定義輸出值

module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;
   
    // step 1 轉移條件
    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            B: next_state = (in==1'b1) ? B:A;
            A: next_state = (in==1'b1) ? A:B;
        endcase
    end

    // step 2 狀態轉移
    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        state <= (areset) ? B:next_state ;
    end

    // step 3 輸出
    // Output logic
    // assign out = (state == ...);
    //assign out = (state == B);
	//輸出; 建議用時序邏輯, 用組合邏輯容易產生毛刺
    always @(posedge clk, posedge areset) begin
        if (areset)
            out <= 1'b1;
        else if (next_state==B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end
endmodule