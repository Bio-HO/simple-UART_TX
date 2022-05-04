//uart design, UART start when trig low, start from in[0]

//module uart_tx(trig,in,out,clk,done,rst);
module uart_tx(trig,out,clk,done,rst_n);
input rst_n;
wire rst=!(rst_n);
input clk;
input trig;
//input[7:0] in;
parameter[7:0] in=8'b01001011;
output reg out;
output done=(state==4'b0000);
reg[3:0] state,next_state;

wire baud_clk;
clk50M_baud dev1(clk,baud_clk,rst);

//always@(posedge clk or posedge rst)
always@(posedge baud_clk or posedge rst)
begin
	if(rst)
	state<=4'b0000;
	else
	state<=next_state;
end

always@(state or trig or in)
begin
	case(state)
		4'b0000:
		begin
			out<=1'b1;
			next_state<=(!trig)?4'b0001:4'b0000;
		end
		
		4'b0001:
		begin
			out<=1'b0;
			next_state<=4'b0010;
		end
		
		4'b0010:
		begin
			out<=in[0];
			next_state<=4'b0011;
		end
		
		4'b0011:
		begin
			out<=in[1];
			next_state<=4'b0100;
		end
		
		4'b0100:
		begin
			out<=in[2];
			next_state<=4'b0101;
		end
		
		4'b0101:
		begin
			out<=in[3];
			next_state<=4'b0110;
		end
		
		4'b0110:
		begin
			out<=in[4];
			next_state<=4'b0111;
		end
		
		4'b0111:
		begin
			out<=in[5];
			next_state<=4'b1000;
		end
		
		4'b1000:
		begin
			out<=in[6];
			next_state<=4'b1001;
		end
		
		4'b1001:
		begin
			out<=in[7];
			next_state<=4'b0000;
		end
		
		default:
		begin
			out<=1'b1;
			next_state<=4'b0000;
		end
	endcase
end

endmodule
