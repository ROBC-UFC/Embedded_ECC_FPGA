module Decoder_ip
(
    output logic [31:0]PRDATA,
    output logic PREADY,
    output logic PSLVERR,
    input logic [31:0]PADDR,
    input logic [31:0]PWDATA,
    input logic PSEL,
    input logic PENABLE,
    input logic PWRITE,
    input logic PCLK,
    input logic PRESETn
);

localparam DECODER_IP_IN1 = 0; 
localparam DECODER_IP_IN2 = 4;
localparam DECODER_IP_OUT = 8;

logic [31:0] in1_ff;
logic [31:0] in2_ff;

logic [31:0] decoder_out;
logic [31:0] mux_bus;

logic [39:0] codeword;
logic en;


assign write_en = PSEL & PWRITE & PENABLE;
assign read_en = PSEL & ~PWRITE;

assign in1_sel = (PADDR[4:0] == DECODER_IP_IN1);
assign in2_sel = (PADDR[4:0] == DECODER_IP_IN2);
assign out_sel = (PADDR[4:0] == DECODER_IP_OUT);

always_ff @(posedge PCLK) begin
    if(!PRESETn) begin
        in1_ff <= {32{1'b0}};
    end
    else begin
        if(in1_sel & write_en) begin
            in1_ff <= PWDATA;
        end
    end
end

always_ff @(posedge PCLK) begin
    if(!PRESETn) begin
        in2_ff <= {32{1'b0}};
    end
    else begin
        if(in2_sel & write_en) begin
            in2_ff <= PWDATA;
        end
    end
end

assign codeword = {in2_ff[7:0],in1_ff[31:0]};
decodificador CLC_DECODER(.codeword(codeword),.en(en),.outsinal(decoder_out[15:0]));

assign mux_bus = (   in1_ff) & {32{in1_sel}} |
                 (   in2_ff) & {32{in2_sel}} |
                 (decoder_out) & {32{out_sel}} ;
                 
                 
always_ff @(posedge PCLK) begin
    if(read_en) begin
        PRDATA <= mux_bus;
    end
end

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;
assign en = 1'b1;
endmodule

