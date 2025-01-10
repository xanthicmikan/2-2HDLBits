//branch prediction
module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg[1:0] state
);
    parameter SNT=0,WNT=1,WT=2,ST=3;
    
    always@(posedge clk or posedge areset)
    begin
        if(areset)
            state <= WNT;
        else if(train_valid)begin
            case(state)
                SNT:state <= train_taken ? WNT : SNT;
                WNT:state <= train_taken ? WT : SNT;
                WT:state <= train_taken ? ST : WNT;
                ST:state <= train_taken  ?ST : WT;
            endcase
        end
    end
    

endmodule


