module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter A=0,B=1;
    reg state;
    reg next_state;
    reg [1:0]cle;
    reg [1:0]cout;
    always@(*)begin
        if(state==A)next_state=s?B:A;
        else next_state=B;
    end
    
    always@(posedge clk)begin
        if(reset)begin state<=A;end
        else begin state<=next_state;end
    end
    always@(posedge clk)begin
        if(reset||state==A)begin 
            cle<=0;
            cout<=0;
        end
        else begin
            if(cle<=2'b10)cle<=cle+1'b1;
            else cle<=2'b1;
            
            if(cle==2'b11)cout<=w;
            else cout<=cout+w;
            
                
        end
    end
    assign z=(cout==2'b10)&&(cle==2'b11);
    
endmodule

//这题的后半部分3个cycle数出两个1用状态机太难搞了，不如现在这种偏逻辑的解法
