module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	
    parameter SEARCH=0, BBYTE1=1, BBYTE2=2, BBYTE3=3, CBYTE1=4, CBYTE2=5,CBYTE3=6;
    
    reg [2:0]state;
    reg [2:0]next_state;
    
    always@(*)begin
        case(state)
            SEARCH:begin
                if(in[3]==1'b1)next_state=BBYTE1;
                else next_state=SEARCH;
            end
            BBYTE1:next_state=BBYTE2;
            BBYTE2:next_state=BBYTE3;
            BBYTE3:begin
                if(in[3]==1'b1)next_state=CBYTE1;
                else next_state=SEARCH;
            end
            CBYTE1:next_state=CBYTE2;
            CBYTE2:next_state=CBYTE3;
            CBYTE3:begin
                if(in[3]==1'b1)next_state=CBYTE1;
                else next_state=SEARCH;
            end
                
                
            default:next_state=SEARCH;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)state<=SEARCH;
        else state<=next_state;
    end
    assign done=(state==CBYTE3)|(state==BBYTE3);

endmodule


//这题是压根没看出来done是指示byte3的，一开始还以为是指示第二个开始后续bytes的第一个byte什么的，时序不清晰的问题，
//正确只需要四个状态的，完全不用像我这样
