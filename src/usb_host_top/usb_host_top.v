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

module usb_host_top
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           cfg_awvalid_i
    ,input  [ 31:0]  cfg_awaddr_i
    ,input           cfg_wvalid_i
    ,input  [ 31:0]  cfg_wdata_i
    ,input  [  3:0]  cfg_wstrb_i
    ,input           cfg_bready_i
    ,input           cfg_arvalid_i
    ,input  [ 31:0]  cfg_araddr_i
    ,input           cfg_rready_i
    ,input  [  7:0]  ulpi_data_out_i
    ,input           ulpi_dir_i
    ,input           ulpi_nxt_i

    // Outputs
    ,output          cfg_awready_o
    ,output          cfg_wready_o
    ,output          cfg_bvalid_o
    ,output [  1:0]  cfg_bresp_o
    ,output          cfg_arready_o
    ,output          cfg_rvalid_o
    ,output [ 31:0]  cfg_rdata_o
    ,output [  1:0]  cfg_rresp_o
    ,output          intr_o
    ,output [  7:0]  ulpi_data_in_o
    ,output          ulpi_stp_o
);

wire  [  7:0]  utmi_data_out_w;
wire           utmi_rxvalid_w;
wire  [  1:0]  utmi_linestate_w;
wire  [  1:0]  utmi_xcvrselect_w;
wire           utmi_termselect_w;
wire  [  1:0]  utmi_op_mode_w;
wire  [  7:0]  utmi_data_in_w;
wire           utmi_rxerror_w;
wire           utmi_rxactive_w;
wire           utmi_dppulldown_w;
wire           utmi_txready_w;
wire           utmi_txvalid_w;
wire           utmi_dmpulldown_w;


usbh_host
u_usb
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(cfg_awvalid_i)
    ,.cfg_awaddr_i(cfg_awaddr_i)
    ,.cfg_wvalid_i(cfg_wvalid_i)
    ,.cfg_wdata_i(cfg_wdata_i)
    ,.cfg_wstrb_i(cfg_wstrb_i)
    ,.cfg_bready_i(cfg_bready_i)
    ,.cfg_arvalid_i(cfg_arvalid_i)
    ,.cfg_araddr_i(cfg_araddr_i)
    ,.cfg_rready_i(cfg_rready_i)
    ,.utmi_data_in_i(utmi_data_in_w)
    ,.utmi_txready_i(utmi_txready_w)
    ,.utmi_rxvalid_i(utmi_rxvalid_w)
    ,.utmi_rxactive_i(utmi_rxactive_w)
    ,.utmi_rxerror_i(utmi_rxerror_w)
    ,.utmi_linestate_i(utmi_linestate_w)

    // Outputs
    ,.cfg_awready_o(cfg_awready_o)
    ,.cfg_wready_o(cfg_wready_o)
    ,.cfg_bvalid_o(cfg_bvalid_o)
    ,.cfg_bresp_o(cfg_bresp_o)
    ,.cfg_arready_o(cfg_arready_o)
    ,.cfg_rvalid_o(cfg_rvalid_o)
    ,.cfg_rdata_o(cfg_rdata_o)
    ,.cfg_rresp_o(cfg_rresp_o)
    ,.intr_o(intr_o)
    ,.utmi_data_out_o(utmi_data_out_w)
    ,.utmi_txvalid_o(utmi_txvalid_w)
    ,.utmi_op_mode_o(utmi_op_mode_w)
    ,.utmi_xcvrselect_o(utmi_xcvrselect_w)
    ,.utmi_termselect_o(utmi_termselect_w)
    ,.utmi_dppulldown_o(utmi_dppulldown_w)
    ,.utmi_dmpulldown_o(utmi_dmpulldown_w)
);


ulpi_wrapper
u_usb_phy
(
    // Inputs
     .ulpi_clk60_i(clk_i)
    ,.ulpi_rst_i(rst_i)
    ,.ulpi_data_out_i(ulpi_data_out_i)
    ,.ulpi_dir_i(ulpi_dir_i)
    ,.ulpi_nxt_i(ulpi_nxt_i)
    ,.utmi_data_out_i(utmi_data_out_w)
    ,.utmi_txvalid_i(utmi_txvalid_w)
    ,.utmi_op_mode_i(utmi_op_mode_w)
    ,.utmi_xcvrselect_i(utmi_xcvrselect_w)
    ,.utmi_termselect_i(utmi_termselect_w)
    ,.utmi_dppulldown_i(utmi_dppulldown_w)
    ,.utmi_dmpulldown_i(utmi_dmpulldown_w)

    // Outputs
    ,.ulpi_data_in_o(ulpi_data_in_o)
    ,.ulpi_stp_o(ulpi_stp_o)
    ,.utmi_data_in_o(utmi_data_in_w)
    ,.utmi_txready_o(utmi_txready_w)
    ,.utmi_rxvalid_o(utmi_rxvalid_w)
    ,.utmi_rxactive_o(utmi_rxactive_w)
    ,.utmi_rxerror_o(utmi_rxerror_w)
    ,.utmi_linestate_o(utmi_linestate_w)
);



endmodule
