`timescale 1ns / 1ps
module decoder(data_in,data_out,en);
input [0:31] data_in;
input en;
output [0:15] data_out;
reg [0:3] signal [0:3];
reg [0:15]red;
reg [0:1] linsin [0:3];
reg [0:3] SP;
reg [0:3] SDi;
integer b;
integer sumSL=0,sumSP,sumSDi;
integer quad1=0;
integer quad2=0;
always@(en)
begin
	signal[0][0:3]={data_in[0],data_in[4],data_in[8],data_in[12]};
	signal[1][0:3]={data_in[1],data_in[5],data_in[9],data_in[13]};
	signal[2][0:3]={data_in[2],data_in[6],data_in[10],data_in[14]};
	signal[3][0:3]={data_in[3],data_in[7],data_in[11],data_in[15]};
	red[0:15]=data_in[16:31];
	linsin[0][0]=signal[0][0]^signal[0][2]^red[8];
	linsin[0][1]=signal[0][1]^signal[0][3]^red[9];
	linsin[1][0]=signal[1][0]^signal[1][2]^red[10];
    linsin[1][1]=signal[1][1]^signal[1][3]^red[11];
	linsin[2][0]=signal[2][0]^signal[2][2]^red[12];
    linsin[2][1]=signal[2][1]^signal[2][3]^red[13];
	linsin[3][0]=signal[3][0]^signal[3][2]^red[14];
    linsin[3][1]=signal[3][1]^signal[3][3]^red[15];
	
		
	SP[0]=signal[0][0]^signal[0][1]^signal[1][0]^signal[1][1]^red[4];
	SP[1]=signal[2][0]^signal[2][1]^signal[3][0]^signal[3][1]^red[6];
	SP[2]=signal[0][2]^signal[0][3]^signal[1][2]^signal[1][3]^red[7];
	SP[3]=signal[2][2]^signal[2][3]^signal[3][2]^signal[3][3]^red[5];
	sumSP=1*SP[0] + 1*SP[1] + 1*SP[2] + 1*SP[3];
	SDi[0]=signal[0][0]^signal[1][1]^signal[2][0]^signal[3][1]^red[0];
	SDi[1]=signal[0][1]^signal[1][0]^signal[2][1]^signal[3][0]^red[2];
	SDi[2]=signal[0][2]^signal[1][3]^signal[2][2]^signal[3][3]^red[3];
	SDi[3]=signal[0][3]^signal[1][2]^signal[2][3]^signal[3][2]^red[1];
	sumSDi=1*SDi[0] + 1*SDi[1] + 1*SDi[2] + 1*SDi[3];
	
	sumSL=1*linsin[1][0] + 1*linsin[1][1]+ 1*linsin[2][0]+ 1*linsin[2][1]+1*linsin[3][0] + 1*linsin[3][1]+ 1*linsin[0][0]+ 1*linsin[0][1];
	
	if((((SP[0:3] !=4'b0000) & (SDi[0:3] !=4'b0000)) |  sumSL>1) & !((sumSDi==0) & (sumSP==1) & (sumSL>=2)))// condi��o para erros em quadrantes
	begin	
		quad1=1*SP[0]+1*SP[1]+1*SDi[0]+1*SDi[1];
		quad2=1*SP[2]+1*SP[3]+1*SDi[2]+1*SDi[3];
		if(quad1 > quad2)// Erro no primeiro quadrante
		begin
			for(b=0;b<4;b=b+1)
			begin
				if(linsin[b][0:1]!=2'b00)
				signal[b][0:1]=signal[b][0:1]^linsin[b][0:1];
			end
		end
		
		else if(quad1 < quad2)// Erro no segundo quadrante
		begin
			for(b=0;b<4;b=b+1)
			begin
				if(linsin[b][0:1]!=2'b00)
				signal[b][2:3]=signal[b][2:3]^linsin[b][0:1];
			end
		end
		
		else if((quad1 == quad2)&({SP[0],SP[1],SDi[0],SDi[1]} !=4'b0000)) // Erro no quadrante central
		begin
				for(b=0;b<4;b=b+1)
				begin
					if(linsin[b][0:1]!=2'b00)
					signal[b][1:2]=signal[b][1:2]^{linsin[b][1],linsin[b][0]};
				end

		end
	end
end
assign data_out={signal[0][0:3],signal[1][0:3],signal[2][0:3],signal[3][0:3]};

endmodule
