module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
    initial pm=1'b0;
    always@(posedge clk)begin
        if(reset)begin
        	hh <= 8'h12;
            mm <= 8'h0;
            ss <= 8'h0;
            pm <= 1'b0;
        end
        else if(!ena)begin
            hh <= hh;
            mm <= mm;
            ss <= ss;
            pm <= pm;
        end
                
        else if(hh==8'h11 && mm==8'h59 && ss==8'h59)begin
            hh <= 8'h12;
            mm <= 8'h0;
            ss <= 8'h0;
            pm <= ~pm;
        end
        else if(hh==8'h12 && mm==8'h59 && ss==8'h59)begin
            hh <= 8'h1;
            mm <= 8'h0;
            ss <= 8'h0;
            pm <= pm;
        end
        else if(mm==8'h59 && ss==8'h59)begin
            //hh <= hh+8'h1;
            if(hh[3:0]==4'h9) begin
                hh[3:0]<=4'h0;
                hh[7:4]<=hh[7:4]+4'h1;
            end
            else hh <= hh+8'h1;
            
            mm <= 8'h0;
            ss <= 8'h0;
            pm <= pm;
        end
        else if(ss==8'h59)begin
            hh <= hh;
            //mm <= mm+8'h1;
            if(mm[3:0]==4'h9) begin
                mm[3:0]<=4'h0;
                mm[7:4]<=mm[7:4]+4'h1;
            end 
            else mm <= mm+8'h1;
            ss <= 8'h0;
            pm <= pm;
        end
        else begin
            hh <= hh;
            mm <= mm;
            //ss <= ss+8'h1;
            if(ss[3:0]==4'h9) begin
                ss[3:0]<=4'h0;
                ss[7:4]<=ss[7:4]+4'h1;
            end 
            else ss <= ss+8'h1;
            pm <= pm;
        end
        
    end
endmodule
