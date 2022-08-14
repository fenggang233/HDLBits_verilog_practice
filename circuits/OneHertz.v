module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0] Q[2:0];
    

    assign OneHertz = (Q[0]==4'b1001 && Q[1]==4'b1001 && Q[2]==4'b1001);
    
    assign c_enable[0]=1'b1;
    assign c_enable[1]=(Q[0]==4'b1001);
    assign c_enable[2]=(Q[1]==4'b1001)&c_enable[1];
    
    bcdcount counter0 (clk, reset, c_enable[0], Q[0]);
    bcdcount counter1 (clk, reset, c_enable[1], Q[1]);
    bcdcount counter2 (clk, reset, c_enable[2], Q[2]);
    
    

endmodule

//这个比较有意思的是用三个bcd累加计数器组成了一个0-999的计数器，当计数器恰为999的时候，给OneHertz一个脉冲
//要注意的点一个是c_enable[2]必须是十位和个位都是9的时候才能赋1，所以也可以写成assign c_enable[2]=(Q[1]==4'b1001)&(Q[0]==4'b1001);
//第二个点是必须是999的时候才能OneHertz=1,除此以外全是0
