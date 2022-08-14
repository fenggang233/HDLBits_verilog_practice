module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;			// Remember the state of the previous cycle
		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
	end
	
endmodule

//这里是做一个边缘检测，注意的点是d_last是在每个时钟上升沿存一下in的旧值，同时又使用d_last的旧值和in的旧值进行比较检测边缘，必须用非阻塞赋值，不然d_last的值会改
