module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_tmp;
    always@(posedge clk)begin
       in_tmp<=in; 
    end
    always@(posedge clk)begin
        if(reset == 1'b1) out<=32'b0;
        else out<=(in_tmp&~in) | out;
    end
endmodule

//这题感觉要注意的是reset是同步的还是异步的，如果是时钟同步的，就不需要再sensitive list中放入posedge reset，
//同步reset的效果就是如果reset的set和时钟上升沿同步，则reset到下一个时钟上升沿才有效
