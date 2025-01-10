module top_module (
    input [3:1] y,
    input w,
    output Y2);
 
    //Output Y2 : Y2只在兩種情況為1，即狀態C和狀態D，把所有會跳到無法通過狀態情況列舉出來即可。
	//
    parameter A=3'b000;
    parameter B=3'b001;
    parameter C=3'b010;
    parameter D=3'b011;
    parameter E=3'b100; 
    parameter F=3'b101; 
    
    assign Y2=(y==B&&~w)||(y==F&&~w)||(y==B&&w)||(y==C&&w)||(y==E&&w)||(y==F&&w);	
		
    //method 2
	//assign Y2 = (w & ~y[1] & y[2] & ~y[3]) | (w & ~y[2] & y[3]) | (y[1] & ~y[2]);
    
endmodule
