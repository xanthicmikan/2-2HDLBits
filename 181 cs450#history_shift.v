//歷史緩衝區:作用是記錄最近跳轉的信息，供預測器使用。
//注意的就是當發生預測失敗，需要沖刷流水線，
//在預測失敗之後的預測（younger）都需要從歷史緩衝區中沖刷掉
//當predict_valid = 1，移入predict_taken到predict_history，
//當train_mispredicted = 1，移入train_taken到train_history，
//注意misprediction較為優先。(預測失敗的優先權高於預測使能信號)
module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output reg[31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    always@(posedge clk or posedge areset)
    begin
        if(areset)
            predict_history <= 32'd0;
        else if(train_mispredicted)begin
            predict_history <= {train_history[30:0],train_taken};
        end
        else if(predict_valid)begin
            predict_history <= {predict_history[30:0],predict_taken};
        end
    end

endmodule