module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter SEARCH=0,BYTE1=1,BYTE2=2,BYTE3=3;
    reg [1:0]state;
    reg [1:0]next_state;
    
    always@(*)begin
        case(state)
            SEARCH:begin
                if(in[3]==1)begin
                    next_state=BYTE1;
                end
                else begin
                    next_state=SEARCH;
                end
            end
            BYTE1:next_state=BYTE2;
            BYTE2:next_state=BYTE3;
            BYTE3:begin
                if(in[3]==1)next_state=BYTE1;
                else next_state=SEARCH;
            end
            default:next_state=SEARCH;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)begin
            state<=SEARCH;
            out_bytes<=0;
            end 
        else begin 
            state<=next_state;
            out_bytes[23:16]<=(next_state==BYTE1)?in:out_bytes[23:16];
            out_bytes[15:8]<=(next_state==BYTE2)?in:out_bytes[15:8];
            out_bytes[7:0]<=(next_state==BYTE3)?in:out_bytes[7:0];
        end
    end
    assign done=(state==BYTE3);
    

endmodule

//这个是上一题加上数据输出，注意数据的记录位置应该是state跳变的逻辑里，不能放到组合逻辑里
