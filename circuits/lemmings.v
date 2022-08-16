module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter LEFT=0, RIGHT=1,FLEFT=2, FRIGHT=3, DLEFT=4, DRIGHT=5, DEAD=6;
    reg [2:0]state;
    reg [2:0]next_state;
    reg [4:0]fall_time;

    always @(*) begin
        // State transition logic
        case(state)
            DLEFT: next_state = ground ? DLEFT : FLEFT;
            DRIGHT: next_state = ground ? DRIGHT : FRIGHT;               
            
            LEFT: next_state = ground ? (dig ? DLEFT : (bump_left?RIGHT:LEFT)) : FLEFT;
            RIGHT: next_state = ground ? (dig ? DRIGHT : (bump_right?LEFT:RIGHT)) : FRIGHT;
            
            FLEFT: next_state = ground ? (fall_time>5'b10011 ? DEAD : LEFT) : FLEFT;
            FRIGHT: next_state = ground ? (fall_time>5'b10011 ? DEAD : RIGHT) : FRIGHT;
            
            DEAD: next_state = DEAD;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state<=LEFT;
        else state<=next_state;
    end
    
    always@(posedge clk, posedge areset)begin
        if(areset) fall_time<=0;
        else begin
            case(state)
                FLEFT,FRIGHT: begin
                    if(fall_time>5'b10100) fall_time<=fall_time;
                    else fall_time<=fall_time+1'b1;
                end
                default: fall_time <= 0;
            endcase
        end
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FLEFT)|(state == FRIGHT);
    assign digging = (state == DLEFT)|(state == DRIGHT);
    
endmodule

//这个题还挺有意思的，唯一要注意的就是fall_time是有长度的，要是一直加1可能会溢出
