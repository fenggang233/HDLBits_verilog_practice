module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
	
    initial q=16'b0;
    always@(posedge clk)begin
        if(reset) q<=16'b0;
        else if(q[15:0]==16'h9999) q<=16'h0;
        else if(q[11:0]==12'h999) q<={(q[15:12]+4'b1), 12'h0};
        else if(q[7:0]==8'h99) q<={q[15:12], (q[11:8]+4'b1), 8'h0};
        else if(q[3:0]==4'h9) q<={q[15:8], (q[7:4]+4'b1), 4'h0};
        else q<=q+16'h1;
    end
    
    assign ena[1] = q[3:0]==4'h9;
    assign ena[2] = q[7:0]==8'h99;
    assign ena[3] = q[11:0]==12'h999;
    
endmodule

//这里主要困难的地方是bcd加法的控制
