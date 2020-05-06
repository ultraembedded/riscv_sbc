//-----------------------------------------------------------------
//                 USB2Sniffer Linux SBC Project
//                            V0.1
//                     Ultra-Embedded.com
//                       Copyright 2020
//
//                   admin@ultra-embedded.com
//
//                       License: BSD
//-----------------------------------------------------------------
//
// Copyright (c) 2020, Ultra-Embedded.com
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions 
// are met:
//   - Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//   - Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer 
//     in the documentation and/or other materials provided with the 
//     distribution.
//   - Neither the name of the author nor the names of its contributors 
//     may be used to endorse or promote products derived from this 
//     software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE 
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF 
// SUCH DAMAGE.
//-----------------------------------------------------------------
//`define INCLUDE_USB_DEVICE

//-----------------------------------------------------------------
// TOP
//-----------------------------------------------------------------
module top
(
      input         clk100_i

    , output        led0_r_o
    , output        led0_g_o
    , output        led0_b_o
    , output        led1_r_o
    , output        led1_g_o
    , output        led1_b_o

    , output        flash_cs_o
    , output        flash_mosi_o
    , input         flash_miso_i

    , output        uart_tx_o 
    , input         uart_rx_i

    // DDR3 SDRAM
    , inout [15:0]  ddr3_dq
    , inout [1:0]   ddr3_dqs_n
    , inout [1:0]   ddr3_dqs_p
    , output [14:0] ddr3_addr
    , output [2:0]  ddr3_ba
    , output        ddr3_ras_n
    , output        ddr3_cas_n
    , output        ddr3_we_n
    , output        ddr3_reset_n
    , output [0:0]  ddr3_ck_p
    , output [0:0]  ddr3_ck_n
    , output [0:0]  ddr3_cke
    , output [1:0]  ddr3_dm
    , output [0:0]  ddr3_odt

    // USB switch
    , output        ulpi_sw_s
    , output        ulpi_sw_oe_n

    // ULPI0 Interface (USB-Host)
    , output        ulpi0_reset_o
    , inout [7:0]   ulpi0_data_io
    , output        ulpi0_stp_o
    , input         ulpi0_nxt_i
    , input         ulpi0_dir_i
    , input         ulpi0_clk60_i    

    // ULPI1 Interface (USB-Device)
`ifdef INCLUDE_USB_DEVICE
    , output        ulpi1_reset_o
    , inout [7:0]   ulpi1_data_io
    , output        ulpi1_stp_o
    , input         ulpi1_nxt_i
    , input         ulpi1_dir_i
    , input         ulpi1_clk60_i
`endif
);

//-----------------------------------------------------------------
// Implementation
//-----------------------------------------------------------------
wire           clk0;
wire           clk1;
wire           clk_w;
wire           clk_sys_w;
wire           rst_sys_w;

wire           axi_rvalid_w;
wire           axi_wlast_w;
wire           axi_rlast_w;
wire  [  3:0]  axi_arid_w;
wire  [  1:0]  axi_rresp_w;
wire           axi_wvalid_w;
wire  [  7:0]  axi_awlen_w;
wire  [  1:0]  axi_awburst_w;
wire  [  1:0]  axi_bresp_w;
wire  [ 31:0]  axi_rdata_w;
wire           axi_arready_w;
wire           axi_awvalid_w;
wire  [ 31:0]  axi_araddr_w;
wire  [  1:0]  axi_arburst_w;
wire           axi_wready_w;
wire  [  7:0]  axi_arlen_w;
wire           axi_awready_w;
wire  [  3:0]  axi_bid_w;
wire  [  3:0]  axi_wstrb_w;
wire  [  3:0]  axi_awid_w;
wire           axi_rready_w;
wire  [  3:0]  axi_rid_w;
wire           axi_arvalid_w;
wire  [ 31:0]  axi_awaddr_w;
wire           axi_bvalid_w;
wire           axi_bready_w;
wire  [ 31:0]  axi_wdata_w;


wire clk100_buffered_w;

// Input buffering
BUFG IBUF_IN
(
    .I (clk100_i),
    .O (clk100_buffered_w)
);

artix7_pll
u_pll
(
    .clkref_i(clk100_buffered_w),
    .clkout0_o(clk0), // 100
    .clkout1_o(clk1), // 200
    .clkout2_o(clk_w) // 50
);

//-----------------------------------------------------------------
// DDR
//-----------------------------------------------------------------
usb2sniffer_ddr u_ddr
(
    // Inputs
     .clk100_i(clk100_buffered_w)
    ,.clk200_i(clk1)
    ,.inport_awvalid_i(axi_awvalid_w)
    ,.inport_awaddr_i(axi_awaddr_w)
    ,.inport_awid_i(axi_awid_w)
    ,.inport_awlen_i(axi_awlen_w)
    ,.inport_awburst_i(axi_awburst_w)
    ,.inport_wvalid_i(axi_wvalid_w)
    ,.inport_wdata_i(axi_wdata_w)
    ,.inport_wstrb_i(axi_wstrb_w)
    ,.inport_wlast_i(axi_wlast_w)
    ,.inport_bready_i(axi_bready_w)
    ,.inport_arvalid_i(axi_arvalid_w)
    ,.inport_araddr_i(axi_araddr_w)
    ,.inport_arid_i(axi_arid_w)
    ,.inport_arlen_i(axi_arlen_w)
    ,.inport_arburst_i(axi_arburst_w)
    ,.inport_rready_i(axi_rready_w)

    // Outputs
    ,.clk_out_o(clk_sys_w)
    ,.rst_out_o()
    ,.inport_awready_o(axi_awready_w)
    ,.inport_wready_o(axi_wready_w)
    ,.inport_bvalid_o(axi_bvalid_w)
    ,.inport_bresp_o(axi_bresp_w)
    ,.inport_bid_o(axi_bid_w)
    ,.inport_arready_o(axi_arready_w)
    ,.inport_rvalid_o(axi_rvalid_w)
    ,.inport_rdata_o(axi_rdata_w)
    ,.inport_rresp_o(axi_rresp_w)
    ,.inport_rid_o(axi_rid_w)
    ,.inport_rlast_o(axi_rlast_w)
    ,.ddr_ck_p_o(ddr3_ck_p)
    ,.ddr_ck_n_o(ddr3_ck_n)
    ,.ddr_cke_o(ddr3_cke)
    ,.ddr_reset_n_o(ddr3_reset_n)
    ,.ddr_ras_n_o(ddr3_ras_n)
    ,.ddr_cas_n_o(ddr3_cas_n)
    ,.ddr_we_n_o(ddr3_we_n)
    ,.ddr_ba_o(ddr3_ba)
    ,.ddr_addr_o(ddr3_addr)
    ,.ddr_odt_o(ddr3_odt)
    ,.ddr_dm_o(ddr3_dm)
    ,.ddr_dqs_p_io(ddr3_dqs_p)
    ,.ddr_dqs_n_io(ddr3_dqs_n)
    ,.ddr_data_io(ddr3_dq)
);

reset_gen
u_rst_sys
(
     .clk_i(clk_sys_w)
    ,.rst_o(rst_sys_w)
);

//-----------------------------------------------------------------
// USB host
//-----------------------------------------------------------------
wire usb_clk_w;
wire clk_bufg_w;
IBUF u_ibuf ( .I(ulpi0_clk60_i), .O(clk_bufg_w) );
BUFG u_bufg ( .I(clk_bufg_w),    .O(usb_clk_w) );

reset_gen
u_rst_usb
(
     .clk_i(usb_clk_w)
    ,.rst_o(usb_rst_w)
);

// ULPI Buffers
wire [7:0] ulpi_out_w;
wire [7:0] ulpi_in_w;
wire       ulpi_stp_w;

genvar i;
generate  
for (i=0; i < 8; i=i+1)  
begin: gen_buf
    IOBUF 
    #(
        .DRIVE(12),
        .IOSTANDARD("DEFAULT"),
        .SLEW("FAST")
    )
    IOBUF_inst
    (
        .T(ulpi0_dir_i),
        .I(ulpi_out_w[i]),
        .O(ulpi_in_w[i]),
        .IO(ulpi0_data_io[i])
    );
end  
endgenerate  

OBUF 
#(
    .DRIVE(12),
    .IOSTANDARD("DEFAULT"),
    .SLEW("FAST")
)
OBUF_stp
(
    .I(ulpi_stp_w),
    .O(ulpi0_stp_o)
);

assign ulpi0_reset_o = 1'b0;

//-----------------------------------------------------------------
// USB serial device
//-----------------------------------------------------------------
wire uart_txd_w;
wire uart_rxd_w;

// DP = DP2, DM = DM2
assign ulpi_sw_oe_n = 1'b0;
assign ulpi_sw_s    = 1'b1;

`ifdef INCLUDE_USB_DEVICE
usb_serial_top
u_usb
(
    // ULPI
     .ulpi_clk60_i(ulpi1_clk60_i)
    ,.ulpi_reset_o(ulpi1_reset_o)
    ,.ulpi_data_io(ulpi1_data_io)
    ,.ulpi_stp_o(ulpi1_stp_o)
    ,.ulpi_nxt_i(ulpi1_nxt_i)
    ,.ulpi_dir_i(ulpi1_dir_i)

    // UART
    ,.uart_tx_i(uart_txd_w)
    ,.uart_rx_o(uart_rxd_w)
);
`else
assign uart_rxd_w = 1'b1;
`endif

//-----------------------------------------------------------------
// Core
//-----------------------------------------------------------------
wire dbg_txd_w;

wire spi_clk_w;
wire spi_mosi_w;
wire spi_miso_w;
wire [7:0] spi_cs_w;

wire flash_clk_w;
wire flash_mosi_w;
wire flash_miso_w;
wire flash_cs_w;

wire   flash_clk_o  = ~spi_cs_w[0] ? spi_clk_w  : flash_clk_w;
assign flash_mosi_o = ~spi_cs_w[0] ? spi_mosi_w : flash_mosi_w;
assign flash_cs_o   = ~spi_cs_w[0] ? spi_cs_w[0]: flash_cs_w;
assign spi_miso_w   = flash_miso_i;
assign flash_miso_w = flash_miso_i;

STARTUPE2 
u_misc
(
    .CLK(1'd0),
    .GSR(1'd0),
    .GTS(1'd0),
    .KEYCLEARB(1'd0),
    .PACK(1'd0),
    .USRCCLKO(flash_clk_o),
    .USRCCLKTS(1'd0),
    .USRDONEO(1'd1),
    .USRDONETS(1'd1)
);


wire [31:0] gpio_out_w;

fpga_top
u_top
(
     .clk_i(clk_w)
    ,.clk_sys_i(clk_sys_w)
    ,.rst_i(rst_sys_w)

    ,.dbg_rxd_o(dbg_txd_w)
    ,.dbg_txd_i(uart_rx_i)

    ,.uart_tx_o(uart_txd_w)
    ,.uart_rx_i(uart_rx_i & uart_rxd_w)    

    // SPI
    ,.spi_clk_o(spi_clk_w)
    ,.spi_mosi_o(spi_mosi_w)
    ,.spi_miso_i(spi_miso_w)
    ,.spi_cs_o(spi_cs_w)

    // Flash
    ,.flash_clk_o(flash_clk_w)
    ,.flash_mosi_o(flash_mosi_w)
    ,.flash_miso_i(flash_miso_w)
    ,.flash_cs_o(flash_cs_w)

    // GPIO
    ,.gpio_output_o(gpio_out_w)
    ,.gpio_output_enable_o()
    ,.gpio_input_i(32'b0)

    // DDR AXI
    ,.axi_awvalid_o(axi_awvalid_w)
    ,.axi_awaddr_o(axi_awaddr_w)
    ,.axi_awid_o(axi_awid_w)
    ,.axi_awlen_o(axi_awlen_w)
    ,.axi_awburst_o(axi_awburst_w)
    ,.axi_wvalid_o(axi_wvalid_w)
    ,.axi_wdata_o(axi_wdata_w)
    ,.axi_wstrb_o(axi_wstrb_w)
    ,.axi_wlast_o(axi_wlast_w)
    ,.axi_bready_o(axi_bready_w)
    ,.axi_arvalid_o(axi_arvalid_w)
    ,.axi_araddr_o(axi_araddr_w)
    ,.axi_arid_o(axi_arid_w)
    ,.axi_arlen_o(axi_arlen_w)
    ,.axi_arburst_o(axi_arburst_w)
    ,.axi_rready_o(axi_rready_w)    
    ,.axi_awready_i(axi_awready_w)
    ,.axi_wready_i(axi_wready_w)
    ,.axi_bvalid_i(axi_bvalid_w)
    ,.axi_bresp_i(axi_bresp_w)
    ,.axi_bid_i(axi_bid_w)
    ,.axi_arready_i(axi_arready_w)
    ,.axi_rvalid_i(axi_rvalid_w)
    ,.axi_rdata_i(axi_rdata_w)
    ,.axi_rresp_i(axi_rresp_w)
    ,.axi_rid_i(axi_rid_w)
    ,.axi_rlast_i(axi_rlast_w)

    // ULPI
    ,.clk_usb_i(usb_clk_w)
    ,.rst_usb_i(usb_rst_w)    
    ,.ulpi_data_out_i(ulpi_in_w)
    ,.ulpi_dir_i(ulpi0_dir_i)
    ,.ulpi_nxt_i(ulpi0_nxt_i)
    ,.ulpi_data_in_o(ulpi_out_w)
    ,.ulpi_stp_o(ulpi_stp_w)
);


// Xilinx placement pragmas:
//synthesis attribute IOB of txd_q is "TRUE"
reg txd_q;

always @ (posedge clk_w or posedge rst_sys_w)
if (rst_sys_w)
    txd_q <= 1'b1;
else
    txd_q <= dbg_txd_w & uart_txd_w;

// 'OR' two UARTs together
assign uart_tx_o  = txd_q;

assign {led0_r_o, led0_g_o, led0_b_o, led1_r_o, led1_g_o, led1_b_o} = ~gpio_out_w[5:0];

endmodule
