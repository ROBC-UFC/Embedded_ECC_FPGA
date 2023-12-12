
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

localparam HAMMING_DATA_ADDR = 0; 

logic [31:0] code_in;
logic [31:0] code_out;
logic en;

encoder TBEC_RSC_ENCODER(.data_in(code_in),.data_out(code_out),.en(en));

assign write_en = PSEL & PWRITE & PENABLE;
assign read_en = PSEL & ~PWRITE;

always_ff @(posedge PCLK) begin
    if(!PRESETn) begin
        code_in <= {32{1'b0}};
    end
    else begin
        if(write_en) begin
            code_in <= {16'h0, PWDATA[15:0]};
        end
        else begin
            if(read_en) begin
                code_in <= code_out;
            end
        end
    end
end
                 
                 
assign PRDATA = code_in;

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;
assign en = 1'b1;

endmodule
