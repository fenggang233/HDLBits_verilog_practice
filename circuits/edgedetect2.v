module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] in_tmp;
    always@(posedge clk)begin
        in_tmp <= in;
        anyedge <= in_tmp^in;
    end
endmodule
