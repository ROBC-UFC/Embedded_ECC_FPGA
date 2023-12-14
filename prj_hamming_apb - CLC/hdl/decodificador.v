`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:20 02/25/2017 
// Design Name: 
// Module Name:    decodificador 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decodificador(codeword,en,outsinal);

output wire[0:15]outsinal;
input [0:39]codeword;
input en;
reg [0:7] signal[0:4];
reg [0:2] linsin[0:4];
reg [0:4] spl;
reg [0:7]colsin;
integer j;
integer b;
integer numlinsin=0;
wire clk;
always@(en)
begin
	signal[0][0:7]=codeword[0:7];
	signal[1][0:7]=codeword[8:15];
	signal[2][0:7]=codeword[16:23];
	signal[3][0:7]=codeword[24:31];
	signal[4][0:7]=codeword[32:39];
	
	for(b=0;b<8;b=b+1)
	begin
		colsin[b]=signal[0][b]^signal[1][b]^signal[2][b]^signal[3][b]^signal[4][b];		
	end
	for(b=0;b<5;b=b+1)
	begin
		linsin[b][2]=signal[b][0]^signal[b][1]^signal[b][3]^signal[b][4];
		linsin[b][1]=signal[b][0]^signal[b][2]^signal[b][3]^signal[b][5];
		linsin[b][0]=signal[b][1]^signal[b][2]^signal[b][3]^signal[b][6];
		spl[b]=^signal[b];
	end
	numlinsin= 1*(|linsin[0] || spl[0])+ 1*(|linsin[1] || spl[1])+1 *(|linsin[2] || spl[2])+ 1*(|linsin[3] || spl[3])+ 1*(|linsin[4] || spl[4]);
	for(b=0;b<4;b=b+1)
	begin
		if((numlinsin==1) && (linsin[b]!=3'b000))
		begin
			for(j=0;j<8;j=j+1)
				if(colsin[j]!=1'b0)
					signal[b][j]=~signal[b][j];
		end
		else if((spl[b]!=1'b0) && (linsin[b]==3'b000))
		begin
			for(j=0;j<8;j=j+1)
				if(colsin[j]!=1'b0)
					signal[b][j]=~signal[b][j];
		end
		else if(linsin[b]!=3'b000)
		begin
			if(spl[b]==1'b0)
			begin
				for(j=0;j<8;j=j+1)
					if(colsin[j]!=1'b0)
						signal[b][j]=~signal[b][j];
			end
			else if(spl[b]==1'b1)
			begin
				case(linsin[b])
				3'b001:
				begin
					signal[b][6]=~signal[b][6];
				end
				3'b010:
				begin
					signal[b][5]=~signal[b][5];
				end
				3'b100:
				begin
					signal[b][4]=~signal[b][4];
				end
				3'b111:
				begin
					signal[b][3]=~signal[b][3];
				end
				3'b110:
				begin
					signal[b][2]=~signal[b][2];
				end
				3'b101:
				begin
					signal[b][1]=~signal[b][1];
				end
				3'b011:
				begin
					signal[b][0]=~signal[b][0];
				end
				3'b000:
				begin
					
				end
				endcase
			end
		end
	end		
end
assign outsinal={signal[0][0:3],signal[1][0:3],signal[2][0:3],signal[3][0:3]};
endmodule
