module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
	assign c_enable = enable;
    assign c_d = 1'b1;
    assign c_load = (reset | (Q==4'b1100&&enable==1'b1));
    count4 the_counter (clk, c_enable, c_load, c_d, Q);

endmodule

//这道题一个有意思的点是不再把计数器的累加交给你做，而是要求你给出各个输入，实际的计数累加则交给通用累加器做
//然后注意题目里说对于count4，load信号是优先于enable信号的，也就是如果交给count4的c_enable=0,而c_load=1,count4仍然是要进行load，这肯定有问题，
//所以需要c_load包含关于enable的逻辑
