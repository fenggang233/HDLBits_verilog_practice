module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    
 
    always@(posedge clk or posedge areset)begin
        if(areset==1'b1) q<=8'b0;
        else q<=d;
    end
    
endmodule
// 一个是不要把上下沿信号和电平信号一起放在敏感变量列表中，另一个是注意reset也是可以捕捉上下沿的
