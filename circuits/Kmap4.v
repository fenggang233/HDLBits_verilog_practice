module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    //assign out = ((a^b)&~(c^d)) | ((c^d)&~(a^b));
    assign out = (a^b)^(c^d);
endmodule

//没用卡诺简化，但是这样更简单
