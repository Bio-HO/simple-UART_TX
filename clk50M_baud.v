module clk50M_baud(clk_50M,baud_clk,rst);
input clk_50M;
input rst;
output reg baud_clk;
reg [11:0] count;

always@(posedge clk_50M or posedge rst)
begin
	if(rst)
	begin
		count<=1'b0;
		baud_clk<=1'b0;
	end
	else
	begin
		if(count==12'd2604) //9600
		//if(count==9'd217)	//115200
		begin
			count<=12'b0;
			baud_clk<=~baud_clk;
		end
		else
		begin
			count<=count+1'b1;
			baud_clk<=baud_clk;
		end
	end
end

endmodule
