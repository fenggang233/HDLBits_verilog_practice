module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

   	parameter SE=0,BE=1,C1=2,C2=3,C3=4,C4=5,C5=6,C6=7,C7=8,C8=9,ED_P=10,SEARCH_ED=11,CP=12,ED_UP=13;
    
    reg [3:0]state;
    reg [3:0]next_state;
    reg odd;

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
            C8:next_state = CP;
            CP:next_state = in?(odd?ED_P:ED_UP):SEARCH_ED;
            ED_P:next_state = in?SE:BE;
            ED_UP:next_state = in?SE:BE;
            SEARCH_ED:next_state = in?SE:SEARCH_ED;    
            default:next_state = SE;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)begin
            state<=SE;
            out_byte<=8'b0;
            odd <= 0;
        end
        else begin
            state<=next_state;
            case(next_state)
                C1:begin out_byte<={out_byte[7:1], in}; odd<=in;end
                C2:begin out_byte<={out_byte[7:2], in, out_byte[0]}; odd<=odd+in; end
                C3:begin out_byte<={out_byte[7:3], in, out_byte[1:0]}; odd<=odd+in; end
                C4:begin out_byte<={out_byte[7:4], in, out_byte[2:0]}; odd<=odd+in; end
                C5:begin out_byte<={out_byte[7:5], in, out_byte[3:0]}; odd<=odd+in; end
                C6:begin out_byte<={out_byte[7:6], in, out_byte[4:0]}; odd<=odd+in; end
                C7:begin out_byte<={out_byte[7], in, out_byte[5:0]}; odd<=odd+in; end
                C8:begin out_byte<={in, out_byte[6:0]}; odd=odd+in; end
                CP:begin out_byte<=out_byte; odd<=odd+in;end
                default:begin out_byte<=out_byte;odd<=odd;end
            endcase
        end
    end
    assign done=(state==ED_P);   

endmodule

//这是要加上奇检验的逻辑代码，比如让我直接这样写我是知道odd要随state一起变化记录，然后结束ED要改为ED_P（pass）和ED_UP的，然后在state=CP(接收第九个检验bit的时候)时用odd检查
//但是题目是要求用给出来的已实现模型


//然后正确的例化方式是
//parity p0(.clk(clk), .reset(next_state==BE), .in(in), .odd(odd));
//之前我一直是用state==BE来作为reset的
//原因是next-state是BE的时候，随着clk上升，state转为BE，p0被复位，下一个clk上升时，state转为C1，p0开始读in
