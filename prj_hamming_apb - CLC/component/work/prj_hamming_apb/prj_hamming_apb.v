//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Dec 12 12:49:09 2023
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// prj_hamming_apb
module prj_hamming_apb(
    // Inputs
    DEVRST_N,
    // Outputs
    GPIO_0_M2F
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output GPIO_0_M2F;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] Decoder_ip_0_PRDATA;
wire          Decoder_ip_0_PREADY;
wire          Decoder_ip_0_PSLVERR;
wire          DEVRST_N;
wire          GPIO_0_M2F_net_0;
wire   [31:0] prj_hamming_apb_sb_0_AMBA_SLAVE_0_PADDR;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_0_PENABLE;
wire   [31:0] prj_hamming_apb_sb_0_AMBA_SLAVE_0_PRDATA;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_0_PREADY;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSELx;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSLVERR;
wire   [31:0] prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWDATA;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWRITE;
wire   [31:0] prj_hamming_apb_sb_0_AMBA_SLAVE_1_PADDRS;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_1_PENABLES;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_1_PSELS1;
wire   [31:0] prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWDATAS;
wire          prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWRITES;
wire          prj_hamming_apb_sb_0_FIC_0_CLK;
wire          prj_hamming_apb_sb_0_POWER_ON_RESET_N;
wire          GPIO_0_M2F_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign GPIO_0_M2F_net_1 = GPIO_0_M2F_net_0;
assign GPIO_0_M2F       = GPIO_0_M2F_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------adder_ip
adder_ip Codificador(
        // Inputs
        .PSEL    ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSELx ),
        .PENABLE ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PENABLE ),
        .PWRITE  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWRITE ),
        .PCLK    ( prj_hamming_apb_sb_0_FIC_0_CLK ),
        .PRESETn ( prj_hamming_apb_sb_0_POWER_ON_RESET_N ),
        .PADDR   ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PADDR ),
        .PWDATA  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWDATA ),
        // Outputs
        .PREADY  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PREADY ),
        .PSLVERR ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSLVERR ),
        .PRDATA  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PRDATA ) 
        );

//--------Decoder_ip
Decoder_ip Decoder_ip_0(
        // Inputs
        .PADDR   ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PADDRS ),
        .PWDATA  ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWDATAS ),
        .PSEL    ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PSELS1 ),
        .PENABLE ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PENABLES ),
        .PWRITE  ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWRITES ),
        .PCLK    ( prj_hamming_apb_sb_0_FIC_0_CLK ),
        .PRESETn ( prj_hamming_apb_sb_0_POWER_ON_RESET_N ),
        // Outputs
        .PRDATA  ( Decoder_ip_0_PRDATA ),
        .PREADY  ( Decoder_ip_0_PREADY ),
        .PSLVERR ( Decoder_ip_0_PSLVERR ) 
        );

//--------prj_hamming_apb_sb
prj_hamming_apb_sb prj_hamming_apb_sb_0(
        // Inputs
        .FAB_RESET_N            ( prj_hamming_apb_sb_0_POWER_ON_RESET_N ),
        .AMBA_SLAVE_0_PRDATAS0  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PRDATA ),
        .AMBA_SLAVE_0_PREADYS0  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PREADY ),
        .AMBA_SLAVE_0_PSLVERRS0 ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSLVERR ),
        .AMBA_SLAVE_1_PRDATAS1  ( Decoder_ip_0_PRDATA ),
        .AMBA_SLAVE_1_PREADYS1  ( Decoder_ip_0_PREADY ),
        .AMBA_SLAVE_1_PSLVERRS1 ( Decoder_ip_0_PSLVERR ),
        .DEVRST_N               ( DEVRST_N ),
        // Outputs
        .POWER_ON_RESET_N       ( prj_hamming_apb_sb_0_POWER_ON_RESET_N ),
        .INIT_DONE              (  ),
        .AMBA_SLAVE_0_PADDRS    ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PADDR ),
        .AMBA_SLAVE_0_PSELS0    ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PSELx ),
        .AMBA_SLAVE_0_PENABLES  ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PENABLE ),
        .AMBA_SLAVE_0_PWRITES   ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWRITE ),
        .AMBA_SLAVE_0_PWDATAS   ( prj_hamming_apb_sb_0_AMBA_SLAVE_0_PWDATA ),
        .AMBA_SLAVE_1_PADDRS    ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PADDRS ),
        .AMBA_SLAVE_1_PSELS1    ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PSELS1 ),
        .AMBA_SLAVE_1_PENABLES  ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PENABLES ),
        .AMBA_SLAVE_1_PWRITES   ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWRITES ),
        .AMBA_SLAVE_1_PWDATAS   ( prj_hamming_apb_sb_0_AMBA_SLAVE_1_PWDATAS ),
        .FIC_0_CLK              ( prj_hamming_apb_sb_0_FIC_0_CLK ),
        .FIC_0_LOCK             (  ),
        .MSS_READY              (  ),
        .GPIO_0_M2F             ( GPIO_0_M2F_net_0 ) 
        );


endmodule
