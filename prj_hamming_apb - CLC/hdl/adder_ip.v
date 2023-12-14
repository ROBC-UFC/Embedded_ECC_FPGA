module adder_ip
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

localparam ENCODER_IP_IN = 0; 
localparam ENCODER_IP_OUT1 = 4;
localparam ENCODER_IP_OUT2 = 8;

logic [31:0] in_ff;
logic [31:0] encoder_out1;
logic [31:0] encoder_out2;
logic [31:0] mux_bus;

logic en;
logic [39:0] outsinal;

assign write_en = PSEL & PWRITE & PENABLE;
assign read_en = PSEL & ~PWRITE;

assign in_sel = (PADDR[4:0] == ENCODER_IP_IN);
assign out1_sel = (PADDR[4:0] == ENCODER_IP_OUT1);
assign out2_sel = (PADDR[4:0] == ENCODER_IP_OUT2);

always_ff @(posedge PCLK) begin
    if(!PRESETn) begin
        in_ff <= {32{1'b0}};
    end
    else begin
        if(in_sel & write_en) begin
            in_ff <= PWDATA;
        end
    end
end


codificador CLC_ENCODER(.codeword(in_ff[15:0]),.en(en),.outsinal(outsinal[39:0]));
assign encoder_out1 = outsinal[31:0] ;
assign encoder_out2 = {24'h0,outsinal[39:32]};

assign mux_bus = (   in_ff) & {32{in_sel}} |
                 (   encoder_out1) & {32{out1_sel}} |
                 (encoder_out2) & {32{out2_sel}} ;
                 
                 
always_ff @(posedge PCLK) begin
    if(read_en) begin
        PRDATA <= mux_bus;
    end
end

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;
assign en = 1'b1;
endmodule
