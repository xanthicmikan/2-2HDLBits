module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

   parameter IDLE=2'b00, TRANS=2'b01, DONE=2'b10, WAIT=2'b11; 
   reg [1:0] state, next_state;
   reg [5:0] counter;
   reg [7:0] data;
   
   //counter
   always @(posedge clk) begin
    if(reset) begin
	    counter <= 6'd0;
	end
	else begin
	     if(state == TRANS)begin
		    counter <= counter + 1'd1;
		 end
		 else begin
		    counter <= 6'd0;
		 end
	end//else
   end//always

    //狀態轉移
	always @(*)begin
	    case(state) 
		IDLE:next_state <= in? IDLE:TRANS;
		TRANS: begin
		 if(counter ==6'd8)begin
		    if(in == 1'd1) begin
			    next_state <= DONE;
			end
			else begin
			    next_state <= WAIT;
			end
		 end
		 else begin
		    next_state <= TRANS; 
		 end
		end
		DONE:next_state <= in? IDLE:TRANS;
		WAIT:next_state <= in? IDLE:WAIT;
		
	    endcase
	end
	
	always @(posedge clk) begin
        state <= (reset) ? IDLE:next_state ;
    end

    always @(posedge clk) begin
        if (reset) begin
            data <= 0;
        end
        else begin
            case (next_state)
                TRANS: data<={in,data[7:1]};
                default: data<=data;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 0;
        end
        else begin
            case (next_state)
                DONE: out_byte <= data;
                default: out_byte <= 0;
            endcase
        end
    end

    assign done = (state == DONE);

endmodule