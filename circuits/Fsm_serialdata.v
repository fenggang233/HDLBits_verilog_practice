module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	parameter SE=0,BE=1,C1=2,C2=3,C3=4,C4=5,C5=6,C6=7,C7=8,C8=9,ED=10,SEARCH_ED=11;
    
    reg [3:0]state;
    reg [3:0]next_state;
    
    always@(*)begin
        case(state)
            SE:next_state = in?SE:BE;
            BE:next_state = C1;
            C1:next_state = C2;
            C2:next_state = C3;
            C3:next_state = C4;
            C4:next_state = C5;
            C5:next_state = C6;
            C6:next_state = C7;
            C7:next_state = C8;
            C8:next_state = in?ED:SEARCH_ED;
            ED:next_state = in?SE:BE;
            SEARCH_ED:next_state = in?SE:SEARCH_ED;    
            default:next_state = SE;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)begin
            state<=SE;
            out_byte<=8'b0;
        end
        else begin
            state<=next_state;
            case(next_state)
                C1:out_byte<={out_byte[7:1], in};
                C2:out_byte<={out_byte[7:2], in, out_byte[0]};
                C3:out_byte<={out_byte[7:3], in, out_byte[1:0]};
                C4:out_byte<={out_byte[7:4], in, out_byte[2:0]};
                C5:out_byte<={out_byte[7:5], in, out_byte[3:0]};
                C6:out_byte<={out_byte[7:6], in, out_byte[4:0]};
                C7:out_byte<={out_byte[7], in, out_byte[5:0]};
                C8:out_byte<={in, out_byte[6:0]};
		
                default:out_byte<=out_byte;
            endcase
        end
    end
            
    assign done=(state==ED);
   

endmodule

//这个需要注意的是如果8个bit全部收到了，下一个不是1的时候，需要等待一个1，才能继续进行数据的接收，不能直接开始寻找下一串数据，所以必须要有SEARCH_ED状态
