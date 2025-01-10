//Conwaylife
//需要计算邻域1的个数，注意这里的边界比较复杂，每个点都有8个邻点，成一个环形结构。
//方法比较笨，就是把所有情况全部考虑一遍，注意以下几点：
//1、verilog运算自动按位数最多的运算数来计算，所以计算下标时使用i-8'd15而不是i-15。
//2、因为我想让循环数溢出，所以取的8位i。
//网上查了一下，看了别人的做法，大致有以下几类：
//1、和hdlbits提示的一样使用sv语法，使用二维数组，可以大大简化逻辑。
//2、将矩阵拓展为18*18，从而减少情况的考虑。

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg[255:0] q ); 
    
    reg [3:0]neig_cnt;
    reg [255:0] q_next;
    
    always@(posedge clk)
    begin
        if(load)
            q <= data;
        else begin
            q <= q_next;
        end
    end
    reg [15:0]loop;
    reg unsigned[7:0]i;
    always@(*)
    begin
        for(loop=0;loop<256;loop=loop+1)
        begin
            i=loop;
            if(i==255)//左上角
                neig_cnt = q[i-8'd15]+q[i+8'd1]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd31];
            else if(i==240)//右上角
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd31]+q[i+8'd15]+q[i-8'd1]+q[i-8'd16]+q[i-8'd15];
            else if(i==15)//左下角
                neig_cnt = q[i-8'd15]+q[i+8'd1]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd31];
            else if(i==0)//右下角
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd31]+q[i+8'd15]+q[i-8'd1]+q[i-8'd16]+q[i-8'd15];
            else if(i>240)//上方
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd15];
            else if(i%16==15)//左方
                neig_cnt = q[i-8'd15]+q[i+8'd1]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd31];
            else if(i%16==0)//右方
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd31]+q[i+8'd15]+q[i-8'd1]+q[i-8'd16]+q[i-8'd15];
            else if(i<15)//下方
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd15];
            else//中间的点
                neig_cnt = q[i+8'd1]+q[i+8'd17]+q[i+8'd16]+q[i+8'd15]+q[i-8'd1]+q[i-8'd17]+q[i-8'd16]+q[i-8'd15];
            
            if(neig_cnt == 0||neig_cnt == 1)
                q_next[i] = 0;
            else if(neig_cnt == 2)
                q_next[i] = q[i];
            else if(neig_cnt == 3)
                q_next[i] = 1;
            else
                q_next[i] = 0;
        end 
    end
endmodule




//////////
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [255:0] q_next;
    integer i, j;
    integer i_s, i_a, j_s, j_a;
    
    always @(*) begin
        for(i = 0; i < 16; ++ i)
            for(j = 0; j < 16; ++ j)
                begin
                    if(i == 0)
                        i_s = 15;
                    else
                        i_s = i - 1;
                    
                    if(j == 0)
                        j_s = 15;
                    else
                        j_s = j - 1;
                    
                    if(i == 15)
                        i_a = 0;
                    else
                        i_a = i + 1;
                    
                    if(j == 15)
                        j_a = 0;
                    else
                        j_a = j + 1;
                    
                    case(q[i_a+j_s*16] + q[i_s+j_a*16] + q[i_s+j_s*16] + q[i_a+j_a*16] + q[i_s+j*16] + q[i_a+j*16] + q[i+j_s*16] + q[i+j_a*16])
                        4'b0010: q_next[i+j*16] <= q[i+j*16];
                        4'b0011: q_next[i+j*16] <= 1;
                        default: q_next[i+j*16] <= 0;
                    endcase
                end
    end
    
    always @(posedge clk) begin
        if(load)
            q <= data;
        else
	    	q <= q_next;
    end

endmodule