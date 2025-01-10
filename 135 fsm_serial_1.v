module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

   parameter IDLE=2'b00, TRANS=2'b01, DONE=2'b10, WAIT=2'b11; 
   reg [1:0] state, next_state;
   reg [5:0] counter;
   
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

    assign done = (state == DONE);

endmodule