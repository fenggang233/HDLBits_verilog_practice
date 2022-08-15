module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        case(state)
            A:next_state = ~in;
            B:next_state = in;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if(areset) state<=B;
        else state<=next_state;
    end

	assign out = state;

endmodule

//这个算是典型的有限状态机模板了
