module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// We have 6 states here.
	// A2<1; D>S3; S1<B1<S2 & dfr=0; B2 is from C state
	parameter A2=0, B1=1, B2=2, C1=3, C2=4, D1=5;
	reg [2:0] state, next;		
	
	always @(posedge clk) begin
		if (reset) 
		    state <= A2;
		else 
		    state <= next;
	end

    //step 2 狀態轉換
    // Combinational always block: Use blocking assignments.    
	always@(*) begin
		case (state)
			A2: next = s[1] ? B1 : A2;
			B1: next = s[2] ? C1 : (s[1] ? B1 : A2);
			B2: next = s[2] ? C1 : (s[1] ? B2 : A2);
			C1: next = s[3] ? D1 : (s[2] ? C1 : B2);
			C2: next = s[3] ? D1 : (s[2] ? C2 : B2);
			D1: next = s[3] ? D1 : C2;
			default: next = 'x;
		endcase
	end
	
	
	// Combinational output logic.
	// step 3 輸出
	always@(*) begin
		case (state)
			A2: {fr3, fr2, fr1, dfr} = 4'b1111;
			B1: {fr3, fr2, fr1, dfr} = 4'b0110;
			B2: {fr3, fr2, fr1, dfr} = 4'b0111;
			C1: {fr3, fr2, fr1, dfr} = 4'b0010;
			C2: {fr3, fr2, fr1, dfr} = 4'b0011;
			D1: {fr3, fr2, fr1, dfr} = 4'b0000;
			default: {fr3, fr2, fr1, dfr} = 'x;
		endcase
	end
	
endmodule