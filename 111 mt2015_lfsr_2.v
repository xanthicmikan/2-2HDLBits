//Combinational Logic + Sequential Logic
module top_module (
 input [2:0] SW,      // R
 input [1:0] KEY,     // L and clk
 output [2:0] LEDR);  // Q

    reg [2:0] LEDR_next;
    always @(*) begin
        if (KEY[1]) //L
            LEDR_next = SW;
        else
            begin
                LEDR_next[2] = LEDR[2]^LEDR[1];
                LEDR_next[1] = LEDR[0];
                LEDR_next[0] = LEDR[2];
            end
    end
    
    always @(posedge KEY[0]) begin //clk
        LEDR <= LEDR_next;
    end

endmodule