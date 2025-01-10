//分支預測器: 實現"飽和計數器"，四個狀態，說白了taken=1就往強選擇狀態移動，taken=0往強不選狀態移動
module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg[1:0] state
);
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= 2'b01;
        else if(train_valid) begin
             if(train_taken)
			   state <= (state == 2'b11) ? 2'b11 : (state + 1);
			 else
			   state <= (state == 2'b00) ? 2'b00 : (state - 1);
        end
    end
   
endmodule