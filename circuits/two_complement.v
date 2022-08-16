module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	//取补码的过程，首先读的为0，下一个周期输出0，第一次读到1之后后面全部取反
    parameter Z=0,O1=1,T=2;
    reg [2:0]state;
    reg [2:0]next_state;
    
    always@(*)begin
        case(state)
            Z:next_state = x?O1:Z;
            O1:next_state = T;
            T:next_state = T;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset)begin state<=Z; z<=0;end
        else begin state<=next_state; z<=next_state==T?~x:x; end
    end
        
    
endmodule
//这题让我觉得不太理解moore和mearl状态机的区别，需要复习下数电
