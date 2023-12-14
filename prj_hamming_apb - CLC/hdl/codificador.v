module codificador(codeword,en,outsinal);

output wire[0:39]outsinal;
input [0:15]codeword;
input en;
reg [0:3] signal[0:3];
reg [0:2] linsin[0:3];
reg [0:7] codedsignal[0:3];
reg [0:3] spl;
reg [0:7]colsin;
integer b;

always@(en)
begin

	signal[0][0:3]=codeword[0:3];
	signal[1][0:3]=codeword[4:7];	
	signal[2][0:3]=codeword[8:11];	
	signal[3][0:3]=codeword[12:15];		
	
	//$monitor("monitor signal: %b %b ", signal[0],signal[1]);
	for(b=0;b<4;b=b+1)
	begin
		linsin[b][2]=signal[b][0]^signal[b][1]^signal[b][3];
		linsin[b][1]=signal[b][0]^signal[b][2]^signal[b][3];
		linsin[b][0]=signal[b][1]^signal[b][2]^signal[b][3];
		spl[b]=(^signal[b])^(^linsin[b]);
	end
	
	codedsignal[0][0:7]={signal[0][0:3],linsin[0][0:2],spl[0]};
	codedsignal[1][0:7]={signal[1][0:3],linsin[1][0:2],spl[1]};
	codedsignal[2][0:7]={signal[2][0:3],linsin[2][0:2],spl[2]};
	codedsignal[3][0:7]={signal[3][0:3],linsin[3][0:2],spl[3]};

		
	for(b=0;b<8;b=b+1)
	begin
		colsin[b]=codedsignal[0][b]^codedsignal[1][b]^codedsignal[2][b]^codedsignal[3][b];			
	end
end

assign outsinal={codedsignal[0],codedsignal[1],codedsignal[2],codedsignal[3],colsin[0:7]};

endmodule