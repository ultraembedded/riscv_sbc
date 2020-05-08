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

module fpga_top
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter CLK_FREQ         = 50000000
    ,parameter BAUDRATE         = 1000000
    ,parameter UART_SPEED       = 1000000
    ,parameter C_SCK_RATIO      = 8
    ,parameter MEM_CACHE_ADDR_MIN = 32'h80000000
    ,parameter MEM_CACHE_ADDR_MAX = 32'h8fffffff
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    // Inputs
     input           clk_i
    ,input           clk_sys_i
    ,input           rst_i
    ,input           clk_usb_i
    ,input           rst_usb_i
    ,input           dbg_txd_i
    ,input           spi_miso_i
    ,input           uart_rx_i
    ,input  [ 31:0]  gpio_input_i
    ,input           axi_awready_i
    ,input           axi_wready_i
    ,input           axi_bvalid_i
    ,input  [  1:0]  axi_bresp_i
    ,input  [  3:0]  axi_bid_i
    ,input           axi_arready_i
    ,input           axi_rvalid_i
    ,input  [ 31:0]  axi_rdata_i
    ,input  [  1:0]  axi_rresp_i
    ,input  [  3:0]  axi_rid_i
    ,input           axi_rlast_i
    ,input           flash_miso_i
    ,input  [  7:0]  ulpi_data_out_i
    ,input           ulpi_dir_i
    ,input           ulpi_nxt_i

    // Outputs
    ,output          dbg_rxd_o
    ,output          spi_clk_o
    ,output          spi_mosi_o
    ,output [  7:0]  spi_cs_o
    ,output          uart_tx_o
    ,output [ 31:0]  gpio_output_o
    ,output [ 31:0]  gpio_output_enable_o
    ,output          axi_awvalid_o
    ,output [ 31:0]  axi_awaddr_o
    ,output [  3:0]  axi_awid_o
    ,output [  7:0]  axi_awlen_o
    ,output [  1:0]  axi_awburst_o
    ,output          axi_wvalid_o
    ,output [ 31:0]  axi_wdata_o
    ,output [  3:0]  axi_wstrb_o
    ,output          axi_wlast_o
    ,output          axi_bready_o
    ,output          axi_arvalid_o
    ,output [ 31:0]  axi_araddr_o
    ,output [  3:0]  axi_arid_o
    ,output [  7:0]  axi_arlen_o
    ,output [  1:0]  axi_arburst_o
    ,output          axi_rready_o
    ,output          flash_clk_o
    ,output          flash_mosi_o
    ,output          flash_cs_o
    ,output [  7:0]  ulpi_data_in_o
    ,output          ulpi_stp_o
);

wire           axi_d_awvalid_w;
wire  [  1:0]  axi_i_bresp_w;
wire           axi_dist_outport1_wvalid_w;
wire           axi_dist_outport0_rready_w;
wire  [ 31:0]  axi_d_araddr_w;
wire           axi_cfg_wvalid_w;
wire  [ 31:0]  axi_dist_outport0_awaddr_w;
wire  [ 31:0]  axi_dist_outport1_araddr_w;
wire  [  3:0]  axi_dist_outport1_wstrb_w;
wire  [  7:0]  axi_dist_outport0_arlen_w;
wire  [  1:0]  axi_i_rresp_w;
wire  [ 31:0]  axi_d_wdata_w;
wire           axi_dist_inport_wvalid_w;
wire  [  3:0]  axi_d_awid_w;
wire           usb_irq_w;
wire           axi_dist_outport0_wvalid_w;
wire  [  3:0]  axi_dist_outport0_wstrb_w;
wire           axi_dist_outport0_bready_w;
wire           axi_t_wlast_w;
wire           axi_i_rvalid_w;
wire           axi_t_arvalid_w;
wire  [  7:0]  axi_d_awlen_w;
wire  [  1:0]  axi_i_arburst_w;
wire           axi_t_awvalid_w;
wire  [ 31:0]  axi_i_rdata_w;
wire           axi_i_rlast_w;
wire           axi_t_bready_w;
wire           axi_d_arvalid_w;
wire           axi_t_arready_w;
wire           axi_cfg_bvalid_w;
wire  [  1:0]  axi_dist_outport1_arburst_w;
wire           usb_cfg_out_awready_w;
wire           axi_dist_outport0_rvalid_w;
wire           axi_dist_inport_bready_w;
wire  [  3:0]  axi_t_rid_w;
wire           axi_dist_outport1_rvalid_w;
wire           axi_dist_outport1_bready_w;
wire           axi_i_arvalid_w;
wire           axi_dist_outport0_wready_w;
wire  [ 31:0]  axi_dist_inport_rdata_w;
wire  [ 31:0]  axi_cfg_rdata_w;
wire  [  1:0]  axi_d_bresp_w;
wire  [  3:0]  axi_cfg_wstrb_w;
wire           usb_cfg_in_wvalid_w;
wire  [  7:0]  axi_dist_outport1_awlen_w;
wire           interrupt_w;
wire           axi_dist_outport1_rready_w;
wire  [  1:0]  axi_t_awburst_w;
wire           axi_i_rready_w;
wire  [  3:0]  axi_t_wstrb_w;
wire           axi_i_wvalid_w;
wire           rst_cpu_w;
wire           axi_cfg_bready_w;
wire  [  3:0]  axi_dist_outport0_arid_w;
wire  [ 31:0]  axi_dist_inport_wdata_w;
wire           axi_dist_outport0_arready_w;
wire  [ 31:0]  usb_cfg_out_awaddr_w;
wire           axi_dist_inport_rvalid_w;
wire  [ 31:0]  axi_dist_outport0_wdata_w;
wire  [ 31:0]  axi_d_awaddr_w;
wire  [  1:0]  axi_dist_inport_rresp_w;
wire  [ 31:0]  axi_t_wdata_w;
wire           axi_t_rlast_w;
wire           axi_d_wvalid_w;
wire           usb_cfg_in_awvalid_w;
wire           axi_cfg_wready_w;
wire           axi_t_rready_w;
wire           usb_cfg_out_rvalid_w;
wire  [ 31:0]  axi_dist_inport_awaddr_w;
wire           axi_d_wlast_w;
wire  [ 31:0]  axi_t_awaddr_w;
wire           usb_cfg_out_bready_w;
wire           axi_dist_outport0_awvalid_w;
wire           axi_i_wlast_w;
wire  [  1:0]  axi_dist_inport_awburst_w;
wire  [  3:0]  axi_dist_outport1_rid_w;
wire           axi_d_rready_w;
wire           axi_t_rvalid_w;
wire           usb_cfg_in_bready_w;
wire           axi_cfg_awvalid_w;
wire  [  7:0]  axi_dist_outport1_arlen_w;
wire           axi_dist_outport1_wready_w;
wire           axi_dist_outport0_arvalid_w;
wire  [ 31:0]  axi_t_araddr_w;
wire  [ 31:0]  axi_dist_outport1_wdata_w;
wire  [  7:0]  axi_dist_outport0_awlen_w;
wire  [ 31:0]  usb_cfg_in_wdata_w;
wire  [ 31:0]  axi_dist_outport1_awaddr_w;
wire  [  1:0]  axi_t_rresp_w;
wire           axi_dist_outport1_rlast_w;
wire  [ 31:0]  axi_d_rdata_w;
wire  [  1:0]  axi_dist_outport0_bresp_w;
wire           usb_cfg_out_bvalid_w;
wire           axi_d_wready_w;
wire  [  3:0]  axi_dist_outport1_bid_w;
wire  [  3:0]  axi_t_awid_w;
wire           axi_d_rvalid_w;
wire  [ 31:0]  axi_dist_inport_araddr_w;
wire  [  7:0]  axi_i_awlen_w;
wire           axi_dist_outport0_awready_w;
wire  [ 31:0]  axi_i_wdata_w;
wire  [ 31:0]  axi_i_araddr_w;
wire  [  3:0]  axi_d_arid_w;
wire  [  1:0]  axi_i_awburst_w;
wire  [ 31:0]  axi_cfg_wdata_w;
wire  [ 31:0]  usb_cfg_in_awaddr_w;
wire  [  1:0]  axi_t_arburst_w;
wire           usb_cfg_in_bvalid_w;
wire  [  1:0]  axi_t_bresp_w;
wire           usb_cfg_out_arready_w;
wire           usb_cfg_in_rready_w;
wire  [ 31:0]  axi_cfg_araddr_w;
wire           axi_i_bvalid_w;
wire           axi_dist_inport_arvalid_w;
wire  [  3:0]  axi_dist_inport_awid_w;
wire           usb_cfg_in_arready_w;
wire  [  3:0]  axi_dist_outport1_arid_w;
wire           axi_dist_outport0_wlast_w;
wire  [ 31:0]  usb_cfg_out_wdata_w;
wire  [ 31:0]  usb_cfg_out_rdata_w;
wire  [  3:0]  axi_i_awid_w;
wire           usb_cfg_in_arvalid_w;
wire  [  3:0]  axi_t_arid_w;
wire           usb_cfg_in_wready_w;
wire           axi_t_awready_w;
wire  [  7:0]  axi_t_arlen_w;
wire           axi_i_arready_w;
wire           axi_t_wvalid_w;
wire           usb_cfg_in_rvalid_w;
wire           usb_cfg_out_arvalid_w;
wire  [ 31:0]  axi_dist_outport0_rdata_w;
wire           usb_cfg_out_rready_w;
wire  [  1:0]  axi_d_arburst_w;
wire  [  1:0]  axi_d_rresp_w;
wire           axi_dist_inport_awready_w;
wire  [  3:0]  axi_t_bid_w;
wire  [  7:0]  axi_t_awlen_w;
wire  [  3:0]  axi_dist_outport0_rid_w;
wire  [ 31:0]  enable_w;
wire  [  1:0]  axi_dist_outport1_awburst_w;
wire  [ 31:0]  reset_vector_w;
wire  [  3:0]  axi_d_bid_w;
wire  [  3:0]  axi_i_rid_w;
wire           axi_cfg_arvalid_w;
wire  [  7:0]  axi_dist_inport_awlen_w;
wire  [  3:0]  usb_cfg_in_wstrb_w;
wire  [  1:0]  axi_d_awburst_w;
wire           axi_dist_inport_rready_w;
wire  [ 31:0]  axi_i_awaddr_w;
wire  [  3:0]  axi_dist_inport_arid_w;
wire           axi_dist_outport1_arvalid_w;
wire           axi_cfg_rvalid_w;
wire  [ 31:0]  usb_cfg_in_araddr_w;
wire           axi_dist_inport_awvalid_w;
wire           usb_cfg_out_awvalid_w;
wire  [  1:0]  axi_dist_outport1_bresp_w;
wire  [  3:0]  axi_dist_inport_bid_w;
wire           axi_dist_inport_arready_w;
wire           axi_i_awready_w;
wire           axi_dist_outport0_bvalid_w;
wire           axi_i_awvalid_w;
wire           axi_d_rlast_w;
wire           axi_i_wready_w;
wire  [  3:0]  axi_d_rid_w;
wire  [  3:0]  axi_dist_outport0_awid_w;
wire  [  3:0]  usb_cfg_out_wstrb_w;
wire  [  1:0]  axi_dist_outport1_rresp_w;
wire           axi_dist_outport1_wlast_w;
wire  [  7:0]  axi_d_arlen_w;
wire  [  3:0]  axi_i_wstrb_w;
wire           axi_dist_inport_wready_w;
wire           axi_t_bvalid_w;
wire           usb_cfg_out_wvalid_w;
wire           axi_dist_inport_rlast_w;
wire  [ 31:0]  axi_dist_outport0_araddr_w;
wire  [  3:0]  axi_dist_inport_rid_w;
wire  [  1:0]  usb_cfg_out_bresp_w;
wire  [ 31:0]  usb_cfg_out_araddr_w;
wire           axi_dist_outport1_arready_w;
wire  [  3:0]  axi_i_bid_w;
wire           axi_d_awready_w;
wire  [  1:0]  axi_dist_outport0_rresp_w;
wire  [  7:0]  axi_i_arlen_w;
wire  [  1:0]  axi_dist_inport_bresp_w;
wire  [  1:0]  axi_dist_outport0_arburst_w;
wire           axi_dist_outport1_bvalid_w;
wire  [  3:0]  axi_d_wstrb_w;
wire           axi_dist_outport1_awvalid_w;
wire  [  1:0]  usb_cfg_out_rresp_w;
wire           axi_dist_inport_wlast_w;
wire  [  1:0]  axi_dist_outport0_awburst_w;
wire  [  7:0]  axi_dist_inport_arlen_w;
wire  [ 31:0]  axi_dist_outport1_rdata_w;
wire           axi_cfg_rready_w;
wire  [  1:0]  axi_dist_inport_arburst_w;
wire           axi_d_bready_w;
wire  [  3:0]  axi_dist_outport0_bid_w;
wire  [  3:0]  axi_dist_outport1_awid_w;
wire           axi_dist_inport_bvalid_w;
wire  [  1:0]  usb_cfg_in_bresp_w;
wire  [ 31:0]  axi_cfg_awaddr_w;
wire  [ 31:0]  usb_cfg_in_rdata_w;
wire           axi_i_bready_w;
wire           usb_cfg_out_wready_w;
wire           axi_d_bvalid_w;
wire  [  3:0]  axi_i_arid_w;
wire  [  1:0]  usb_cfg_in_rresp_w;
wire           axi_dist_outport0_rlast_w;
wire           usb_cfg_in_awready_w;
wire           axi_t_wready_w;
wire  [  1:0]  axi_cfg_rresp_w;
wire  [ 31:0]  axi_t_rdata_w;
wire           axi_d_arready_w;
wire           axi_cfg_awready_w;
wire           axi_dist_outport1_awready_w;
wire  [  1:0]  axi_cfg_bresp_w;
wire  [  3:0]  axi_dist_inport_wstrb_w;
wire           axi_cfg_arready_w;


axi4_cdc
u_cdc
(
    // Inputs
     .wr_clk_i(clk_i)
    ,.wr_rst_i(rst_i)
    ,.inport_awvalid_i(axi_dist_outport0_awvalid_w)
    ,.inport_awaddr_i(axi_dist_outport0_awaddr_w)
    ,.inport_awid_i(axi_dist_outport0_awid_w)
    ,.inport_awlen_i(axi_dist_outport0_awlen_w)
    ,.inport_awburst_i(axi_dist_outport0_awburst_w)
    ,.inport_wvalid_i(axi_dist_outport0_wvalid_w)
    ,.inport_wdata_i(axi_dist_outport0_wdata_w)
    ,.inport_wstrb_i(axi_dist_outport0_wstrb_w)
    ,.inport_wlast_i(axi_dist_outport0_wlast_w)
    ,.inport_bready_i(axi_dist_outport0_bready_w)
    ,.inport_arvalid_i(axi_dist_outport0_arvalid_w)
    ,.inport_araddr_i(axi_dist_outport0_araddr_w)
    ,.inport_arid_i(axi_dist_outport0_arid_w)
    ,.inport_arlen_i(axi_dist_outport0_arlen_w)
    ,.inport_arburst_i(axi_dist_outport0_arburst_w)
    ,.inport_rready_i(axi_dist_outport0_rready_w)
    ,.rd_clk_i(clk_sys_i)
    ,.rd_rst_i(rst_i)
    ,.outport_awready_i(axi_awready_i)
    ,.outport_wready_i(axi_wready_i)
    ,.outport_bvalid_i(axi_bvalid_i)
    ,.outport_bresp_i(axi_bresp_i)
    ,.outport_bid_i(axi_bid_i)
    ,.outport_arready_i(axi_arready_i)
    ,.outport_rvalid_i(axi_rvalid_i)
    ,.outport_rdata_i(axi_rdata_i)
    ,.outport_rresp_i(axi_rresp_i)
    ,.outport_rid_i(axi_rid_i)
    ,.outport_rlast_i(axi_rlast_i)

    // Outputs
    ,.inport_awready_o(axi_dist_outport0_awready_w)
    ,.inport_wready_o(axi_dist_outport0_wready_w)
    ,.inport_bvalid_o(axi_dist_outport0_bvalid_w)
    ,.inport_bresp_o(axi_dist_outport0_bresp_w)
    ,.inport_bid_o(axi_dist_outport0_bid_w)
    ,.inport_arready_o(axi_dist_outport0_arready_w)
    ,.inport_rvalid_o(axi_dist_outport0_rvalid_w)
    ,.inport_rdata_o(axi_dist_outport0_rdata_w)
    ,.inport_rresp_o(axi_dist_outport0_rresp_w)
    ,.inport_rid_o(axi_dist_outport0_rid_w)
    ,.inport_rlast_o(axi_dist_outport0_rlast_w)
    ,.outport_awvalid_o(axi_awvalid_o)
    ,.outport_awaddr_o(axi_awaddr_o)
    ,.outport_awid_o(axi_awid_o)
    ,.outport_awlen_o(axi_awlen_o)
    ,.outport_awburst_o(axi_awburst_o)
    ,.outport_wvalid_o(axi_wvalid_o)
    ,.outport_wdata_o(axi_wdata_o)
    ,.outport_wstrb_o(axi_wstrb_o)
    ,.outport_wlast_o(axi_wlast_o)
    ,.outport_bready_o(axi_bready_o)
    ,.outport_arvalid_o(axi_arvalid_o)
    ,.outport_araddr_o(axi_araddr_o)
    ,.outport_arid_o(axi_arid_o)
    ,.outport_arlen_o(axi_arlen_o)
    ,.outport_arburst_o(axi_arburst_o)
    ,.outport_rready_o(axi_rready_o)
);


usb_host_top
u_usb
(
    // Inputs
     .clk_i(clk_usb_i)
    ,.rst_i(rst_usb_i)
    ,.cfg_awvalid_i(usb_cfg_out_awvalid_w)
    ,.cfg_awaddr_i(usb_cfg_out_awaddr_w)
    ,.cfg_wvalid_i(usb_cfg_out_wvalid_w)
    ,.cfg_wdata_i(usb_cfg_out_wdata_w)
    ,.cfg_wstrb_i(usb_cfg_out_wstrb_w)
    ,.cfg_bready_i(usb_cfg_out_bready_w)
    ,.cfg_arvalid_i(usb_cfg_out_arvalid_w)
    ,.cfg_araddr_i(usb_cfg_out_araddr_w)
    ,.cfg_rready_i(usb_cfg_out_rready_w)
    ,.ulpi_data_out_i(ulpi_data_out_i)
    ,.ulpi_dir_i(ulpi_dir_i)
    ,.ulpi_nxt_i(ulpi_nxt_i)

    // Outputs
    ,.cfg_awready_o(usb_cfg_out_awready_w)
    ,.cfg_wready_o(usb_cfg_out_wready_w)
    ,.cfg_bvalid_o(usb_cfg_out_bvalid_w)
    ,.cfg_bresp_o(usb_cfg_out_bresp_w)
    ,.cfg_arready_o(usb_cfg_out_arready_w)
    ,.cfg_rvalid_o(usb_cfg_out_rvalid_w)
    ,.cfg_rdata_o(usb_cfg_out_rdata_w)
    ,.cfg_rresp_o(usb_cfg_out_rresp_w)
    ,.intr_o(usb_irq_w)
    ,.ulpi_data_in_o(ulpi_data_in_o)
    ,.ulpi_stp_o(ulpi_stp_o)
);


core_soc
#(
     .CLK_FREQ(CLK_FREQ)
    ,.BAUDRATE(BAUDRATE)
    ,.C_SCK_RATIO(C_SCK_RATIO)
)
u_soc
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_cfg_awvalid_w)
    ,.inport_awaddr_i(axi_cfg_awaddr_w)
    ,.inport_wvalid_i(axi_cfg_wvalid_w)
    ,.inport_wdata_i(axi_cfg_wdata_w)
    ,.inport_wstrb_i(axi_cfg_wstrb_w)
    ,.inport_bready_i(axi_cfg_bready_w)
    ,.inport_arvalid_i(axi_cfg_arvalid_w)
    ,.inport_araddr_i(axi_cfg_araddr_w)
    ,.inport_rready_i(axi_cfg_rready_w)
    ,.spi_miso_i(spi_miso_i)
    ,.uart_rx_i(uart_rx_i)
    ,.gpio_input_i(gpio_input_i)
    ,.ext1_cfg_awready_i(usb_cfg_in_awready_w)
    ,.ext1_cfg_wready_i(usb_cfg_in_wready_w)
    ,.ext1_cfg_bvalid_i(usb_cfg_in_bvalid_w)
    ,.ext1_cfg_bresp_i(usb_cfg_in_bresp_w)
    ,.ext1_cfg_arready_i(usb_cfg_in_arready_w)
    ,.ext1_cfg_rvalid_i(usb_cfg_in_rvalid_w)
    ,.ext1_cfg_rdata_i(usb_cfg_in_rdata_w)
    ,.ext1_cfg_rresp_i(usb_cfg_in_rresp_w)
    ,.ext1_irq_i(usb_irq_w)
    ,.ext2_cfg_awready_i(1'b0)
    ,.ext2_cfg_wready_i(1'b0)
    ,.ext2_cfg_bvalid_i(1'b0)
    ,.ext2_cfg_bresp_i(2'b0)
    ,.ext2_cfg_arready_i(1'b0)
    ,.ext2_cfg_rvalid_i(1'b0)
    ,.ext2_cfg_rdata_i(32'b0)
    ,.ext2_cfg_rresp_i(2'b0)
    ,.ext2_irq_i(1'b0)
    ,.ext3_cfg_awready_i(1'b0)
    ,.ext3_cfg_wready_i(1'b0)
    ,.ext3_cfg_bvalid_i(1'b0)
    ,.ext3_cfg_bresp_i(2'b0)
    ,.ext3_cfg_arready_i(1'b0)
    ,.ext3_cfg_rvalid_i(1'b0)
    ,.ext3_cfg_rdata_i(32'b0)
    ,.ext3_cfg_rresp_i(2'b0)
    ,.ext3_irq_i(1'b0)

    // Outputs
    ,.intr_o(interrupt_w)
    ,.inport_awready_o(axi_cfg_awready_w)
    ,.inport_wready_o(axi_cfg_wready_w)
    ,.inport_bvalid_o(axi_cfg_bvalid_w)
    ,.inport_bresp_o(axi_cfg_bresp_w)
    ,.inport_arready_o(axi_cfg_arready_w)
    ,.inport_rvalid_o(axi_cfg_rvalid_w)
    ,.inport_rdata_o(axi_cfg_rdata_w)
    ,.inport_rresp_o(axi_cfg_rresp_w)
    ,.spi_clk_o(spi_clk_o)
    ,.spi_mosi_o(spi_mosi_o)
    ,.spi_cs_o(spi_cs_o)
    ,.uart_tx_o(uart_tx_o)
    ,.gpio_output_o(gpio_output_o)
    ,.gpio_output_enable_o(gpio_output_enable_o)
    ,.ext1_cfg_awvalid_o(usb_cfg_in_awvalid_w)
    ,.ext1_cfg_awaddr_o(usb_cfg_in_awaddr_w)
    ,.ext1_cfg_wvalid_o(usb_cfg_in_wvalid_w)
    ,.ext1_cfg_wdata_o(usb_cfg_in_wdata_w)
    ,.ext1_cfg_wstrb_o(usb_cfg_in_wstrb_w)
    ,.ext1_cfg_bready_o(usb_cfg_in_bready_w)
    ,.ext1_cfg_arvalid_o(usb_cfg_in_arvalid_w)
    ,.ext1_cfg_araddr_o(usb_cfg_in_araddr_w)
    ,.ext1_cfg_rready_o(usb_cfg_in_rready_w)
    ,.ext2_cfg_awvalid_o()
    ,.ext2_cfg_awaddr_o()
    ,.ext2_cfg_wvalid_o()
    ,.ext2_cfg_wdata_o()
    ,.ext2_cfg_wstrb_o()
    ,.ext2_cfg_bready_o()
    ,.ext2_cfg_arvalid_o()
    ,.ext2_cfg_araddr_o()
    ,.ext2_cfg_rready_o()
    ,.ext3_cfg_awvalid_o()
    ,.ext3_cfg_awaddr_o()
    ,.ext3_cfg_wvalid_o()
    ,.ext3_cfg_wdata_o()
    ,.ext3_cfg_wstrb_o()
    ,.ext3_cfg_bready_o()
    ,.ext3_cfg_arvalid_o()
    ,.ext3_cfg_araddr_o()
    ,.ext3_cfg_rready_o()
);


dbg_bridge
#(
     .CLK_FREQ(CLK_FREQ)
    ,.UART_SPEED(UART_SPEED)
)
u_dbg
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.uart_rxd_i(dbg_txd_i)
    ,.mem_awready_i(axi_t_awready_w)
    ,.mem_wready_i(axi_t_wready_w)
    ,.mem_bvalid_i(axi_t_bvalid_w)
    ,.mem_bresp_i(axi_t_bresp_w)
    ,.mem_bid_i(axi_t_bid_w)
    ,.mem_arready_i(axi_t_arready_w)
    ,.mem_rvalid_i(axi_t_rvalid_w)
    ,.mem_rdata_i(axi_t_rdata_w)
    ,.mem_rresp_i(axi_t_rresp_w)
    ,.mem_rid_i(axi_t_rid_w)
    ,.mem_rlast_i(axi_t_rlast_w)
    ,.gpio_inputs_i(enable_w)

    // Outputs
    ,.uart_txd_o(dbg_rxd_o)
    ,.mem_awvalid_o(axi_t_awvalid_w)
    ,.mem_awaddr_o(axi_t_awaddr_w)
    ,.mem_awid_o(axi_t_awid_w)
    ,.mem_awlen_o(axi_t_awlen_w)
    ,.mem_awburst_o(axi_t_awburst_w)
    ,.mem_wvalid_o(axi_t_wvalid_w)
    ,.mem_wdata_o(axi_t_wdata_w)
    ,.mem_wstrb_o(axi_t_wstrb_w)
    ,.mem_wlast_o(axi_t_wlast_w)
    ,.mem_bready_o(axi_t_bready_w)
    ,.mem_arvalid_o(axi_t_arvalid_w)
    ,.mem_araddr_o(axi_t_araddr_w)
    ,.mem_arid_o(axi_t_arid_w)
    ,.mem_arlen_o(axi_t_arlen_w)
    ,.mem_arburst_o(axi_t_arburst_w)
    ,.mem_rready_o(axi_t_rready_w)
    ,.gpio_outputs_o(enable_w)
);


axi4_lite_cdc
u_usb_cdc
(
    // Inputs
     .wr_clk_i(clk_i)
    ,.wr_rst_i(rst_i)
    ,.inport_awvalid_i(usb_cfg_in_awvalid_w)
    ,.inport_awaddr_i(usb_cfg_in_awaddr_w)
    ,.inport_wvalid_i(usb_cfg_in_wvalid_w)
    ,.inport_wdata_i(usb_cfg_in_wdata_w)
    ,.inport_wstrb_i(usb_cfg_in_wstrb_w)
    ,.inport_bready_i(usb_cfg_in_bready_w)
    ,.inport_arvalid_i(usb_cfg_in_arvalid_w)
    ,.inport_araddr_i(usb_cfg_in_araddr_w)
    ,.inport_rready_i(usb_cfg_in_rready_w)
    ,.rd_clk_i(clk_usb_i)
    ,.rd_rst_i(rst_usb_i)
    ,.outport_awready_i(usb_cfg_out_awready_w)
    ,.outport_wready_i(usb_cfg_out_wready_w)
    ,.outport_bvalid_i(usb_cfg_out_bvalid_w)
    ,.outport_bresp_i(usb_cfg_out_bresp_w)
    ,.outport_arready_i(usb_cfg_out_arready_w)
    ,.outport_rvalid_i(usb_cfg_out_rvalid_w)
    ,.outport_rdata_i(usb_cfg_out_rdata_w)
    ,.outport_rresp_i(usb_cfg_out_rresp_w)

    // Outputs
    ,.inport_awready_o(usb_cfg_in_awready_w)
    ,.inport_wready_o(usb_cfg_in_wready_w)
    ,.inport_bvalid_o(usb_cfg_in_bvalid_w)
    ,.inport_bresp_o(usb_cfg_in_bresp_w)
    ,.inport_arready_o(usb_cfg_in_arready_w)
    ,.inport_rvalid_o(usb_cfg_in_rvalid_w)
    ,.inport_rdata_o(usb_cfg_in_rdata_w)
    ,.inport_rresp_o(usb_cfg_in_rresp_w)
    ,.outport_awvalid_o(usb_cfg_out_awvalid_w)
    ,.outport_awaddr_o(usb_cfg_out_awaddr_w)
    ,.outport_wvalid_o(usb_cfg_out_wvalid_w)
    ,.outport_wdata_o(usb_cfg_out_wdata_w)
    ,.outport_wstrb_o(usb_cfg_out_wstrb_w)
    ,.outport_bready_o(usb_cfg_out_bready_w)
    ,.outport_arvalid_o(usb_cfg_out_arvalid_w)
    ,.outport_araddr_o(usb_cfg_out_araddr_w)
    ,.outport_rready_o(usb_cfg_out_rready_w)
);


soc_arb
u_arb
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.debug_awvalid_i(axi_t_awvalid_w)
    ,.debug_awaddr_i(axi_t_awaddr_w)
    ,.debug_awid_i(axi_t_awid_w)
    ,.debug_awlen_i(axi_t_awlen_w)
    ,.debug_awburst_i(axi_t_awburst_w)
    ,.debug_wvalid_i(axi_t_wvalid_w)
    ,.debug_wdata_i(axi_t_wdata_w)
    ,.debug_wstrb_i(axi_t_wstrb_w)
    ,.debug_wlast_i(axi_t_wlast_w)
    ,.debug_bready_i(axi_t_bready_w)
    ,.debug_arvalid_i(axi_t_arvalid_w)
    ,.debug_araddr_i(axi_t_araddr_w)
    ,.debug_arid_i(axi_t_arid_w)
    ,.debug_arlen_i(axi_t_arlen_w)
    ,.debug_arburst_i(axi_t_arburst_w)
    ,.debug_rready_i(axi_t_rready_w)
    ,.mem_awready_i(axi_dist_inport_awready_w)
    ,.mem_wready_i(axi_dist_inport_wready_w)
    ,.mem_bvalid_i(axi_dist_inport_bvalid_w)
    ,.mem_bresp_i(axi_dist_inport_bresp_w)
    ,.mem_bid_i(axi_dist_inport_bid_w)
    ,.mem_arready_i(axi_dist_inport_arready_w)
    ,.mem_rvalid_i(axi_dist_inport_rvalid_w)
    ,.mem_rdata_i(axi_dist_inport_rdata_w)
    ,.mem_rresp_i(axi_dist_inport_rresp_w)
    ,.mem_rid_i(axi_dist_inport_rid_w)
    ,.mem_rlast_i(axi_dist_inport_rlast_w)
    ,.soc_awready_i(axi_cfg_awready_w)
    ,.soc_wready_i(axi_cfg_wready_w)
    ,.soc_bvalid_i(axi_cfg_bvalid_w)
    ,.soc_bresp_i(axi_cfg_bresp_w)
    ,.soc_arready_i(axi_cfg_arready_w)
    ,.soc_rvalid_i(axi_cfg_rvalid_w)
    ,.soc_rdata_i(axi_cfg_rdata_w)
    ,.soc_rresp_i(axi_cfg_rresp_w)
    ,.cpu_i_awvalid_i(axi_i_awvalid_w)
    ,.cpu_i_awaddr_i(axi_i_awaddr_w)
    ,.cpu_i_awid_i(axi_i_awid_w)
    ,.cpu_i_awlen_i(axi_i_awlen_w)
    ,.cpu_i_awburst_i(axi_i_awburst_w)
    ,.cpu_i_wvalid_i(axi_i_wvalid_w)
    ,.cpu_i_wdata_i(axi_i_wdata_w)
    ,.cpu_i_wstrb_i(axi_i_wstrb_w)
    ,.cpu_i_wlast_i(axi_i_wlast_w)
    ,.cpu_i_bready_i(axi_i_bready_w)
    ,.cpu_i_arvalid_i(axi_i_arvalid_w)
    ,.cpu_i_araddr_i(axi_i_araddr_w)
    ,.cpu_i_arid_i(axi_i_arid_w)
    ,.cpu_i_arlen_i(axi_i_arlen_w)
    ,.cpu_i_arburst_i(axi_i_arburst_w)
    ,.cpu_i_rready_i(axi_i_rready_w)
    ,.cpu_d_awvalid_i(axi_d_awvalid_w)
    ,.cpu_d_awaddr_i(axi_d_awaddr_w)
    ,.cpu_d_awid_i(axi_d_awid_w)
    ,.cpu_d_awlen_i(axi_d_awlen_w)
    ,.cpu_d_awburst_i(axi_d_awburst_w)
    ,.cpu_d_wvalid_i(axi_d_wvalid_w)
    ,.cpu_d_wdata_i(axi_d_wdata_w)
    ,.cpu_d_wstrb_i(axi_d_wstrb_w)
    ,.cpu_d_wlast_i(axi_d_wlast_w)
    ,.cpu_d_bready_i(axi_d_bready_w)
    ,.cpu_d_arvalid_i(axi_d_arvalid_w)
    ,.cpu_d_araddr_i(axi_d_araddr_w)
    ,.cpu_d_arid_i(axi_d_arid_w)
    ,.cpu_d_arlen_i(axi_d_arlen_w)
    ,.cpu_d_arburst_i(axi_d_arburst_w)
    ,.cpu_d_rready_i(axi_d_rready_w)

    // Outputs
    ,.debug_awready_o(axi_t_awready_w)
    ,.debug_wready_o(axi_t_wready_w)
    ,.debug_bvalid_o(axi_t_bvalid_w)
    ,.debug_bresp_o(axi_t_bresp_w)
    ,.debug_bid_o(axi_t_bid_w)
    ,.debug_arready_o(axi_t_arready_w)
    ,.debug_rvalid_o(axi_t_rvalid_w)
    ,.debug_rdata_o(axi_t_rdata_w)
    ,.debug_rresp_o(axi_t_rresp_w)
    ,.debug_rid_o(axi_t_rid_w)
    ,.debug_rlast_o(axi_t_rlast_w)
    ,.mem_awvalid_o(axi_dist_inport_awvalid_w)
    ,.mem_awaddr_o(axi_dist_inport_awaddr_w)
    ,.mem_awid_o(axi_dist_inport_awid_w)
    ,.mem_awlen_o(axi_dist_inport_awlen_w)
    ,.mem_awburst_o(axi_dist_inport_awburst_w)
    ,.mem_wvalid_o(axi_dist_inport_wvalid_w)
    ,.mem_wdata_o(axi_dist_inport_wdata_w)
    ,.mem_wstrb_o(axi_dist_inport_wstrb_w)
    ,.mem_wlast_o(axi_dist_inport_wlast_w)
    ,.mem_bready_o(axi_dist_inport_bready_w)
    ,.mem_arvalid_o(axi_dist_inport_arvalid_w)
    ,.mem_araddr_o(axi_dist_inport_araddr_w)
    ,.mem_arid_o(axi_dist_inport_arid_w)
    ,.mem_arlen_o(axi_dist_inport_arlen_w)
    ,.mem_arburst_o(axi_dist_inport_arburst_w)
    ,.mem_rready_o(axi_dist_inport_rready_w)
    ,.soc_awvalid_o(axi_cfg_awvalid_w)
    ,.soc_awaddr_o(axi_cfg_awaddr_w)
    ,.soc_wvalid_o(axi_cfg_wvalid_w)
    ,.soc_wdata_o(axi_cfg_wdata_w)
    ,.soc_wstrb_o(axi_cfg_wstrb_w)
    ,.soc_bready_o(axi_cfg_bready_w)
    ,.soc_arvalid_o(axi_cfg_arvalid_w)
    ,.soc_araddr_o(axi_cfg_araddr_w)
    ,.soc_rready_o(axi_cfg_rready_w)
    ,.cpu_i_awready_o(axi_i_awready_w)
    ,.cpu_i_wready_o(axi_i_wready_w)
    ,.cpu_i_bvalid_o(axi_i_bvalid_w)
    ,.cpu_i_bresp_o(axi_i_bresp_w)
    ,.cpu_i_bid_o(axi_i_bid_w)
    ,.cpu_i_arready_o(axi_i_arready_w)
    ,.cpu_i_rvalid_o(axi_i_rvalid_w)
    ,.cpu_i_rdata_o(axi_i_rdata_w)
    ,.cpu_i_rresp_o(axi_i_rresp_w)
    ,.cpu_i_rid_o(axi_i_rid_w)
    ,.cpu_i_rlast_o(axi_i_rlast_w)
    ,.cpu_d_awready_o(axi_d_awready_w)
    ,.cpu_d_wready_o(axi_d_wready_w)
    ,.cpu_d_bvalid_o(axi_d_bvalid_w)
    ,.cpu_d_bresp_o(axi_d_bresp_w)
    ,.cpu_d_bid_o(axi_d_bid_w)
    ,.cpu_d_arready_o(axi_d_arready_w)
    ,.cpu_d_rvalid_o(axi_d_rvalid_w)
    ,.cpu_d_rdata_o(axi_d_rdata_w)
    ,.cpu_d_rresp_o(axi_d_rresp_w)
    ,.cpu_d_rid_o(axi_d_rid_w)
    ,.cpu_d_rlast_o(axi_d_rlast_w)
);


spirom
u_spi_rom
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_dist_outport1_awvalid_w)
    ,.inport_awaddr_i(axi_dist_outport1_awaddr_w)
    ,.inport_awid_i(axi_dist_outport1_awid_w)
    ,.inport_awlen_i(axi_dist_outport1_awlen_w)
    ,.inport_awburst_i(axi_dist_outport1_awburst_w)
    ,.inport_wvalid_i(axi_dist_outport1_wvalid_w)
    ,.inport_wdata_i(axi_dist_outport1_wdata_w)
    ,.inport_wstrb_i(axi_dist_outport1_wstrb_w)
    ,.inport_wlast_i(axi_dist_outport1_wlast_w)
    ,.inport_bready_i(axi_dist_outport1_bready_w)
    ,.inport_arvalid_i(axi_dist_outport1_arvalid_w)
    ,.inport_araddr_i(axi_dist_outport1_araddr_w)
    ,.inport_arid_i(axi_dist_outport1_arid_w)
    ,.inport_arlen_i(axi_dist_outport1_arlen_w)
    ,.inport_arburst_i(axi_dist_outport1_arburst_w)
    ,.inport_rready_i(axi_dist_outport1_rready_w)
    ,.spi_miso_i(flash_miso_i)

    // Outputs
    ,.inport_awready_o(axi_dist_outport1_awready_w)
    ,.inport_wready_o(axi_dist_outport1_wready_w)
    ,.inport_bvalid_o(axi_dist_outport1_bvalid_w)
    ,.inport_bresp_o(axi_dist_outport1_bresp_w)
    ,.inport_bid_o(axi_dist_outport1_bid_w)
    ,.inport_arready_o(axi_dist_outport1_arready_w)
    ,.inport_rvalid_o(axi_dist_outport1_rvalid_w)
    ,.inport_rdata_o(axi_dist_outport1_rdata_w)
    ,.inport_rresp_o(axi_dist_outport1_rresp_w)
    ,.inport_rid_o(axi_dist_outport1_rid_w)
    ,.inport_rlast_o(axi_dist_outport1_rlast_w)
    ,.spi_clk_o(flash_clk_o)
    ,.spi_mosi_o(flash_mosi_o)
    ,.spi_cs_o(flash_cs_o)
);


axi4_dist
u_axi_dist
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_dist_inport_awvalid_w)
    ,.inport_awaddr_i(axi_dist_inport_awaddr_w)
    ,.inport_awid_i(axi_dist_inport_awid_w)
    ,.inport_awlen_i(axi_dist_inport_awlen_w)
    ,.inport_awburst_i(axi_dist_inport_awburst_w)
    ,.inport_wvalid_i(axi_dist_inport_wvalid_w)
    ,.inport_wdata_i(axi_dist_inport_wdata_w)
    ,.inport_wstrb_i(axi_dist_inport_wstrb_w)
    ,.inport_wlast_i(axi_dist_inport_wlast_w)
    ,.inport_bready_i(axi_dist_inport_bready_w)
    ,.inport_arvalid_i(axi_dist_inport_arvalid_w)
    ,.inport_araddr_i(axi_dist_inport_araddr_w)
    ,.inport_arid_i(axi_dist_inport_arid_w)
    ,.inport_arlen_i(axi_dist_inport_arlen_w)
    ,.inport_arburst_i(axi_dist_inport_arburst_w)
    ,.inport_rready_i(axi_dist_inport_rready_w)
    ,.outport0_awready_i(axi_dist_outport0_awready_w)
    ,.outport0_wready_i(axi_dist_outport0_wready_w)
    ,.outport0_bvalid_i(axi_dist_outport0_bvalid_w)
    ,.outport0_bresp_i(axi_dist_outport0_bresp_w)
    ,.outport0_bid_i(axi_dist_outport0_bid_w)
    ,.outport0_arready_i(axi_dist_outport0_arready_w)
    ,.outport0_rvalid_i(axi_dist_outport0_rvalid_w)
    ,.outport0_rdata_i(axi_dist_outport0_rdata_w)
    ,.outport0_rresp_i(axi_dist_outport0_rresp_w)
    ,.outport0_rid_i(axi_dist_outport0_rid_w)
    ,.outport0_rlast_i(axi_dist_outport0_rlast_w)
    ,.outport1_awready_i(axi_dist_outport1_awready_w)
    ,.outport1_wready_i(axi_dist_outport1_wready_w)
    ,.outport1_bvalid_i(axi_dist_outport1_bvalid_w)
    ,.outport1_bresp_i(axi_dist_outport1_bresp_w)
    ,.outport1_bid_i(axi_dist_outport1_bid_w)
    ,.outport1_arready_i(axi_dist_outport1_arready_w)
    ,.outport1_rvalid_i(axi_dist_outport1_rvalid_w)
    ,.outport1_rdata_i(axi_dist_outport1_rdata_w)
    ,.outport1_rresp_i(axi_dist_outport1_rresp_w)
    ,.outport1_rid_i(axi_dist_outport1_rid_w)
    ,.outport1_rlast_i(axi_dist_outport1_rlast_w)

    // Outputs
    ,.inport_awready_o(axi_dist_inport_awready_w)
    ,.inport_wready_o(axi_dist_inport_wready_w)
    ,.inport_bvalid_o(axi_dist_inport_bvalid_w)
    ,.inport_bresp_o(axi_dist_inport_bresp_w)
    ,.inport_bid_o(axi_dist_inport_bid_w)
    ,.inport_arready_o(axi_dist_inport_arready_w)
    ,.inport_rvalid_o(axi_dist_inport_rvalid_w)
    ,.inport_rdata_o(axi_dist_inport_rdata_w)
    ,.inport_rresp_o(axi_dist_inport_rresp_w)
    ,.inport_rid_o(axi_dist_inport_rid_w)
    ,.inport_rlast_o(axi_dist_inport_rlast_w)
    ,.outport0_awvalid_o(axi_dist_outport0_awvalid_w)
    ,.outport0_awaddr_o(axi_dist_outport0_awaddr_w)
    ,.outport0_awid_o(axi_dist_outport0_awid_w)
    ,.outport0_awlen_o(axi_dist_outport0_awlen_w)
    ,.outport0_awburst_o(axi_dist_outport0_awburst_w)
    ,.outport0_wvalid_o(axi_dist_outport0_wvalid_w)
    ,.outport0_wdata_o(axi_dist_outport0_wdata_w)
    ,.outport0_wstrb_o(axi_dist_outport0_wstrb_w)
    ,.outport0_wlast_o(axi_dist_outport0_wlast_w)
    ,.outport0_bready_o(axi_dist_outport0_bready_w)
    ,.outport0_arvalid_o(axi_dist_outport0_arvalid_w)
    ,.outport0_araddr_o(axi_dist_outport0_araddr_w)
    ,.outport0_arid_o(axi_dist_outport0_arid_w)
    ,.outport0_arlen_o(axi_dist_outport0_arlen_w)
    ,.outport0_arburst_o(axi_dist_outport0_arburst_w)
    ,.outport0_rready_o(axi_dist_outport0_rready_w)
    ,.outport1_awvalid_o(axi_dist_outport1_awvalid_w)
    ,.outport1_awaddr_o(axi_dist_outport1_awaddr_w)
    ,.outport1_awid_o(axi_dist_outport1_awid_w)
    ,.outport1_awlen_o(axi_dist_outport1_awlen_w)
    ,.outport1_awburst_o(axi_dist_outport1_awburst_w)
    ,.outport1_wvalid_o(axi_dist_outport1_wvalid_w)
    ,.outport1_wdata_o(axi_dist_outport1_wdata_w)
    ,.outport1_wstrb_o(axi_dist_outport1_wstrb_w)
    ,.outport1_wlast_o(axi_dist_outport1_wlast_w)
    ,.outport1_bready_o(axi_dist_outport1_bready_w)
    ,.outport1_arvalid_o(axi_dist_outport1_arvalid_w)
    ,.outport1_araddr_o(axi_dist_outport1_araddr_w)
    ,.outport1_arid_o(axi_dist_outport1_arid_w)
    ,.outport1_arlen_o(axi_dist_outport1_arlen_w)
    ,.outport1_arburst_o(axi_dist_outport1_arburst_w)
    ,.outport1_rready_o(axi_dist_outport1_rready_w)
);


riscv_top
#(
     .MEM_CACHE_ADDR_MIN(MEM_CACHE_ADDR_MIN)
    ,.MEM_CACHE_ADDR_MAX(MEM_CACHE_ADDR_MAX)
)
u_cpu
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_cpu_w)
    ,.axi_i_awready_i(axi_i_awready_w)
    ,.axi_i_wready_i(axi_i_wready_w)
    ,.axi_i_bvalid_i(axi_i_bvalid_w)
    ,.axi_i_bresp_i(axi_i_bresp_w)
    ,.axi_i_bid_i(axi_i_bid_w)
    ,.axi_i_arready_i(axi_i_arready_w)
    ,.axi_i_rvalid_i(axi_i_rvalid_w)
    ,.axi_i_rdata_i(axi_i_rdata_w)
    ,.axi_i_rresp_i(axi_i_rresp_w)
    ,.axi_i_rid_i(axi_i_rid_w)
    ,.axi_i_rlast_i(axi_i_rlast_w)
    ,.axi_d_awready_i(axi_d_awready_w)
    ,.axi_d_wready_i(axi_d_wready_w)
    ,.axi_d_bvalid_i(axi_d_bvalid_w)
    ,.axi_d_bresp_i(axi_d_bresp_w)
    ,.axi_d_bid_i(axi_d_bid_w)
    ,.axi_d_arready_i(axi_d_arready_w)
    ,.axi_d_rvalid_i(axi_d_rvalid_w)
    ,.axi_d_rdata_i(axi_d_rdata_w)
    ,.axi_d_rresp_i(axi_d_rresp_w)
    ,.axi_d_rid_i(axi_d_rid_w)
    ,.axi_d_rlast_i(axi_d_rlast_w)
    ,.intr_i(interrupt_w)
    ,.reset_vector_i(reset_vector_w)

    // Outputs
    ,.axi_i_awvalid_o(axi_i_awvalid_w)
    ,.axi_i_awaddr_o(axi_i_awaddr_w)
    ,.axi_i_awid_o(axi_i_awid_w)
    ,.axi_i_awlen_o(axi_i_awlen_w)
    ,.axi_i_awburst_o(axi_i_awburst_w)
    ,.axi_i_wvalid_o(axi_i_wvalid_w)
    ,.axi_i_wdata_o(axi_i_wdata_w)
    ,.axi_i_wstrb_o(axi_i_wstrb_w)
    ,.axi_i_wlast_o(axi_i_wlast_w)
    ,.axi_i_bready_o(axi_i_bready_w)
    ,.axi_i_arvalid_o(axi_i_arvalid_w)
    ,.axi_i_araddr_o(axi_i_araddr_w)
    ,.axi_i_arid_o(axi_i_arid_w)
    ,.axi_i_arlen_o(axi_i_arlen_w)
    ,.axi_i_arburst_o(axi_i_arburst_w)
    ,.axi_i_rready_o(axi_i_rready_w)
    ,.axi_d_awvalid_o(axi_d_awvalid_w)
    ,.axi_d_awaddr_o(axi_d_awaddr_w)
    ,.axi_d_awid_o(axi_d_awid_w)
    ,.axi_d_awlen_o(axi_d_awlen_w)
    ,.axi_d_awburst_o(axi_d_awburst_w)
    ,.axi_d_wvalid_o(axi_d_wvalid_w)
    ,.axi_d_wdata_o(axi_d_wdata_w)
    ,.axi_d_wstrb_o(axi_d_wstrb_w)
    ,.axi_d_wlast_o(axi_d_wlast_w)
    ,.axi_d_bready_o(axi_d_bready_w)
    ,.axi_d_arvalid_o(axi_d_arvalid_w)
    ,.axi_d_araddr_o(axi_d_araddr_w)
    ,.axi_d_arid_o(axi_d_arid_w)
    ,.axi_d_arlen_o(axi_d_arlen_w)
    ,.axi_d_arburst_o(axi_d_arburst_w)
    ,.axi_d_rready_o(axi_d_rready_w)
);


`define DBG_BIT_RELEASE_RESET 0
`define DBG_BIT_ENABLE_DEBUG  1
`define DBG_BIT_CAPTURE_HI    2
`define DBG_BIT_CAPTURE_LO    3
`define DBG_BIT_DEBUG_WRITE   4
`define DBG_BIT_BOOTADDR      5




reg [31:0] reset_vector_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    reset_vector_q <= 32'h88300000;
else if (enable_w[`DBG_BIT_CAPTURE_HI] && enable_w[`DBG_BIT_BOOTADDR])
    reset_vector_q <= {enable_w[31:16], reset_vector_q[15:0]};
else if (enable_w[`DBG_BIT_CAPTURE_LO] && enable_w[`DBG_BIT_BOOTADDR])
    reset_vector_q <= {reset_vector_q[31:16], enable_w[31:16]};

assign reset_vector_w  = reset_vector_q;

reg  reset_q;
wire dbg_rst_w         = ~enable_w[`DBG_BIT_RELEASE_RESET];

reg  ignore_dbg_rst_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ignore_dbg_rst_q <= 1'b1;
else if (~dbg_rst_w)
    ignore_dbg_rst_q <= 1'b0;

wire ignore_dbg_rst_w = ignore_dbg_rst_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    reset_q <= 1'b1;
else
    reset_q <= (dbg_rst_w & ~ignore_dbg_rst_w);

assign rst_cpu_w = reset_q;


endmodule
