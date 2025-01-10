module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [3:0] cnt;
    
    always @(posedge clk) begin
        if (reset) begin
            cnt <= 4'd0;
        end
        else begin
            cnt <= (cnt==4) ? cnt:cnt + 1;
        end
    end
	
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
        end
		//當 reset==1 時，固定拉高 shift_ena 4 個週期。
        else if (cnt==3) begin //早一個clk
            shift_ena <= 0;
        end
        else begin
            shift_ena <= shift_ena;
        end
    end	



endmodule