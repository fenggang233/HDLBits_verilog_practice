module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
	
    full_adder full_adder_0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    
    genvar i;
    generate
        for(i=1;i<100;i=i+1)begin: m_add
            full_adder fadd(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .cout(cout[i]), .sum(sum[i])); 
        end
    endgenerate
endmodule

module full_adder(
	input a,b,
	input cin,
	output cout,
	output sum);
    assign {cout, sum} = a+b+cin;
endmodule

//这里说明了要使用generate语法，注意generate模块需要名称
