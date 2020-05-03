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

module soc_arb
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           debug_awvalid_i
    ,input  [ 31:0]  debug_awaddr_i
    ,input  [  3:0]  debug_awid_i
    ,input  [  7:0]  debug_awlen_i
    ,input  [  1:0]  debug_awburst_i
    ,input           debug_wvalid_i
    ,input  [ 31:0]  debug_wdata_i
    ,input  [  3:0]  debug_wstrb_i
    ,input           debug_wlast_i
    ,input           debug_bready_i
    ,input           debug_arvalid_i
    ,input  [ 31:0]  debug_araddr_i
    ,input  [  3:0]  debug_arid_i
    ,input  [  7:0]  debug_arlen_i
    ,input  [  1:0]  debug_arburst_i
    ,input           debug_rready_i
    ,input           mem_awready_i
    ,input           mem_wready_i
    ,input           mem_bvalid_i
    ,input  [  1:0]  mem_bresp_i
    ,input  [  3:0]  mem_bid_i
    ,input           mem_arready_i
    ,input           mem_rvalid_i
    ,input  [ 31:0]  mem_rdata_i
    ,input  [  1:0]  mem_rresp_i
    ,input  [  3:0]  mem_rid_i
    ,input           mem_rlast_i
    ,input           soc_awready_i
    ,input           soc_wready_i
    ,input           soc_bvalid_i
    ,input  [  1:0]  soc_bresp_i
    ,input           soc_arready_i
    ,input           soc_rvalid_i
    ,input  [ 31:0]  soc_rdata_i
    ,input  [  1:0]  soc_rresp_i
    ,input           cpu_i_awvalid_i
    ,input  [ 31:0]  cpu_i_awaddr_i
    ,input  [  3:0]  cpu_i_awid_i
    ,input  [  7:0]  cpu_i_awlen_i
    ,input  [  1:0]  cpu_i_awburst_i
    ,input           cpu_i_wvalid_i
    ,input  [ 31:0]  cpu_i_wdata_i
    ,input  [  3:0]  cpu_i_wstrb_i
    ,input           cpu_i_wlast_i
    ,input           cpu_i_bready_i
    ,input           cpu_i_arvalid_i
    ,input  [ 31:0]  cpu_i_araddr_i
    ,input  [  3:0]  cpu_i_arid_i
    ,input  [  7:0]  cpu_i_arlen_i
    ,input  [  1:0]  cpu_i_arburst_i
    ,input           cpu_i_rready_i
    ,input           cpu_d_awvalid_i
    ,input  [ 31:0]  cpu_d_awaddr_i
    ,input  [  3:0]  cpu_d_awid_i
    ,input  [  7:0]  cpu_d_awlen_i
    ,input  [  1:0]  cpu_d_awburst_i
    ,input           cpu_d_wvalid_i
    ,input  [ 31:0]  cpu_d_wdata_i
    ,input  [  3:0]  cpu_d_wstrb_i
    ,input           cpu_d_wlast_i
    ,input           cpu_d_bready_i
    ,input           cpu_d_arvalid_i
    ,input  [ 31:0]  cpu_d_araddr_i
    ,input  [  3:0]  cpu_d_arid_i
    ,input  [  7:0]  cpu_d_arlen_i
    ,input  [  1:0]  cpu_d_arburst_i
    ,input           cpu_d_rready_i

    // Outputs
    ,output          debug_awready_o
    ,output          debug_wready_o
    ,output          debug_bvalid_o
    ,output [  1:0]  debug_bresp_o
    ,output [  3:0]  debug_bid_o
    ,output          debug_arready_o
    ,output          debug_rvalid_o
    ,output [ 31:0]  debug_rdata_o
    ,output [  1:0]  debug_rresp_o
    ,output [  3:0]  debug_rid_o
    ,output          debug_rlast_o
    ,output          mem_awvalid_o
    ,output [ 31:0]  mem_awaddr_o
    ,output [  3:0]  mem_awid_o
    ,output [  7:0]  mem_awlen_o
    ,output [  1:0]  mem_awburst_o
    ,output          mem_wvalid_o
    ,output [ 31:0]  mem_wdata_o
    ,output [  3:0]  mem_wstrb_o
    ,output          mem_wlast_o
    ,output          mem_bready_o
    ,output          mem_arvalid_o
    ,output [ 31:0]  mem_araddr_o
    ,output [  3:0]  mem_arid_o
    ,output [  7:0]  mem_arlen_o
    ,output [  1:0]  mem_arburst_o
    ,output          mem_rready_o
    ,output          soc_awvalid_o
    ,output [ 31:0]  soc_awaddr_o
    ,output          soc_wvalid_o
    ,output [ 31:0]  soc_wdata_o
    ,output [  3:0]  soc_wstrb_o
    ,output          soc_bready_o
    ,output          soc_arvalid_o
    ,output [ 31:0]  soc_araddr_o
    ,output          soc_rready_o
    ,output          cpu_i_awready_o
    ,output          cpu_i_wready_o
    ,output          cpu_i_bvalid_o
    ,output [  1:0]  cpu_i_bresp_o
    ,output [  3:0]  cpu_i_bid_o
    ,output          cpu_i_arready_o
    ,output          cpu_i_rvalid_o
    ,output [ 31:0]  cpu_i_rdata_o
    ,output [  1:0]  cpu_i_rresp_o
    ,output [  3:0]  cpu_i_rid_o
    ,output          cpu_i_rlast_o
    ,output          cpu_d_awready_o
    ,output          cpu_d_wready_o
    ,output          cpu_d_bvalid_o
    ,output [  1:0]  cpu_d_bresp_o
    ,output [  3:0]  cpu_d_bid_o
    ,output          cpu_d_arready_o
    ,output          cpu_d_rvalid_o
    ,output [ 31:0]  cpu_d_rdata_o
    ,output [  1:0]  cpu_d_rresp_o
    ,output [  3:0]  cpu_d_rid_o
    ,output          cpu_d_rlast_o
);

wire  [  1:0]  axi_dist_rresp_w;
wire  [  7:0]  axi_dist_arlen_w;
wire  [  1:0]  axi_retime_arburst_w;
wire  [ 31:0]  axi_retime_rdata_w;
wire           axi_retime_wready_w;
wire           axi_retime_arvalid_w;
wire           axi_dist_arvalid_w;
wire  [  3:0]  axi_dist_rid_w;
wire           axi_dist_wvalid_w;
wire           axi_retime_bvalid_w;
wire           axi_dist_arready_w;
wire           axi_retime_bready_w;
wire  [  7:0]  axi_dist_awlen_w;
wire  [  1:0]  axi_retime_awburst_w;
wire  [  3:0]  axi_dist_bid_w;
wire  [  3:0]  axi_retime_wstrb_w;
wire  [ 31:0]  axi_dist_araddr_w;
wire           axi_retime_awready_w;
wire  [  1:0]  axi_retime_bresp_w;
wire           axi_retime_rlast_w;
wire  [  3:0]  axi_retime_arid_w;
wire  [  7:0]  axi_retime_arlen_w;
wire           axi_dist_rvalid_w;
wire           axi_dist_wlast_w;
wire  [  3:0]  axi_retime_awid_w;
wire  [  1:0]  axi_dist_awburst_w;
wire           axi_dist_bready_w;
wire  [  1:0]  axi_dist_arburst_w;
wire           axi_retime_wvalid_w;
wire           axi_dist_bvalid_w;
wire           axi_retime_rready_w;
wire  [ 31:0]  axi_retime_awaddr_w;
wire  [ 31:0]  axi_retime_wdata_w;
wire  [  3:0]  axi_retime_rid_w;
wire  [ 31:0]  axi_dist_wdata_w;
wire           axi_dist_wready_w;
wire  [ 31:0]  axi_dist_rdata_w;
wire           axi_dist_awvalid_w;
wire           axi_retime_arready_w;
wire  [  7:0]  axi_retime_awlen_w;
wire  [  1:0]  axi_retime_rresp_w;
wire  [  3:0]  axi_dist_awid_w;
wire  [  3:0]  axi_retime_bid_w;
wire           axi_retime_wlast_w;
wire           axi_retime_awvalid_w;
wire           axi_retime_rvalid_w;
wire           axi_dist_awready_w;
wire           axi_dist_rready_w;
wire           axi_dist_rlast_w;
wire  [  1:0]  axi_dist_bresp_w;
wire  [  3:0]  axi_dist_arid_w;
wire  [  3:0]  axi_dist_wstrb_w;
wire  [ 31:0]  axi_retime_araddr_w;
wire  [ 31:0]  axi_dist_awaddr_w;


soc_axi_retime
u_retime
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_retime_awvalid_w)
    ,.inport_awaddr_i(axi_retime_awaddr_w)
    ,.inport_awid_i(axi_retime_awid_w)
    ,.inport_awlen_i(axi_retime_awlen_w)
    ,.inport_awburst_i(axi_retime_awburst_w)
    ,.inport_wvalid_i(axi_retime_wvalid_w)
    ,.inport_wdata_i(axi_retime_wdata_w)
    ,.inport_wstrb_i(axi_retime_wstrb_w)
    ,.inport_wlast_i(axi_retime_wlast_w)
    ,.inport_bready_i(axi_retime_bready_w)
    ,.inport_arvalid_i(axi_retime_arvalid_w)
    ,.inport_araddr_i(axi_retime_araddr_w)
    ,.inport_arid_i(axi_retime_arid_w)
    ,.inport_arlen_i(axi_retime_arlen_w)
    ,.inport_arburst_i(axi_retime_arburst_w)
    ,.inport_rready_i(axi_retime_rready_w)
    ,.outport_awready_i(mem_awready_i)
    ,.outport_wready_i(mem_wready_i)
    ,.outport_bvalid_i(mem_bvalid_i)
    ,.outport_bresp_i(mem_bresp_i)
    ,.outport_bid_i(mem_bid_i)
    ,.outport_arready_i(mem_arready_i)
    ,.outport_rvalid_i(mem_rvalid_i)
    ,.outport_rdata_i(mem_rdata_i)
    ,.outport_rresp_i(mem_rresp_i)
    ,.outport_rid_i(mem_rid_i)
    ,.outport_rlast_i(mem_rlast_i)

    // Outputs
    ,.inport_awready_o(axi_retime_awready_w)
    ,.inport_wready_o(axi_retime_wready_w)
    ,.inport_bvalid_o(axi_retime_bvalid_w)
    ,.inport_bresp_o(axi_retime_bresp_w)
    ,.inport_bid_o(axi_retime_bid_w)
    ,.inport_arready_o(axi_retime_arready_w)
    ,.inport_rvalid_o(axi_retime_rvalid_w)
    ,.inport_rdata_o(axi_retime_rdata_w)
    ,.inport_rresp_o(axi_retime_rresp_w)
    ,.inport_rid_o(axi_retime_rid_w)
    ,.inport_rlast_o(axi_retime_rlast_w)
    ,.outport_awvalid_o(mem_awvalid_o)
    ,.outport_awaddr_o(mem_awaddr_o)
    ,.outport_awid_o(mem_awid_o)
    ,.outport_awlen_o(mem_awlen_o)
    ,.outport_awburst_o(mem_awburst_o)
    ,.outport_wvalid_o(mem_wvalid_o)
    ,.outport_wdata_o(mem_wdata_o)
    ,.outport_wstrb_o(mem_wstrb_o)
    ,.outport_wlast_o(mem_wlast_o)
    ,.outport_bready_o(mem_bready_o)
    ,.outport_arvalid_o(mem_arvalid_o)
    ,.outport_araddr_o(mem_araddr_o)
    ,.outport_arid_o(mem_arid_o)
    ,.outport_arlen_o(mem_arlen_o)
    ,.outport_arburst_o(mem_arburst_o)
    ,.outport_rready_o(mem_rready_o)
);


soc_axi_arb
u_arb
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport0_awvalid_i(debug_awvalid_i)
    ,.inport0_awaddr_i(debug_awaddr_i)
    ,.inport0_awid_i(debug_awid_i)
    ,.inport0_awlen_i(debug_awlen_i)
    ,.inport0_awburst_i(debug_awburst_i)
    ,.inport0_wvalid_i(debug_wvalid_i)
    ,.inport0_wdata_i(debug_wdata_i)
    ,.inport0_wstrb_i(debug_wstrb_i)
    ,.inport0_wlast_i(debug_wlast_i)
    ,.inport0_bready_i(debug_bready_i)
    ,.inport0_arvalid_i(debug_arvalid_i)
    ,.inport0_araddr_i(debug_araddr_i)
    ,.inport0_arid_i(debug_arid_i)
    ,.inport0_arlen_i(debug_arlen_i)
    ,.inport0_arburst_i(debug_arburst_i)
    ,.inport0_rready_i(debug_rready_i)
    ,.inport1_awvalid_i(axi_dist_awvalid_w)
    ,.inport1_awaddr_i(axi_dist_awaddr_w)
    ,.inport1_awid_i(axi_dist_awid_w)
    ,.inport1_awlen_i(axi_dist_awlen_w)
    ,.inport1_awburst_i(axi_dist_awburst_w)
    ,.inport1_wvalid_i(axi_dist_wvalid_w)
    ,.inport1_wdata_i(axi_dist_wdata_w)
    ,.inport1_wstrb_i(axi_dist_wstrb_w)
    ,.inport1_wlast_i(axi_dist_wlast_w)
    ,.inport1_bready_i(axi_dist_bready_w)
    ,.inport1_arvalid_i(axi_dist_arvalid_w)
    ,.inport1_araddr_i(axi_dist_araddr_w)
    ,.inport1_arid_i(axi_dist_arid_w)
    ,.inport1_arlen_i(axi_dist_arlen_w)
    ,.inport1_arburst_i(axi_dist_arburst_w)
    ,.inport1_rready_i(axi_dist_rready_w)
    ,.inport2_awvalid_i(cpu_i_awvalid_i)
    ,.inport2_awaddr_i(cpu_i_awaddr_i)
    ,.inport2_awid_i(cpu_i_awid_i)
    ,.inport2_awlen_i(cpu_i_awlen_i)
    ,.inport2_awburst_i(cpu_i_awburst_i)
    ,.inport2_wvalid_i(cpu_i_wvalid_i)
    ,.inport2_wdata_i(cpu_i_wdata_i)
    ,.inport2_wstrb_i(cpu_i_wstrb_i)
    ,.inport2_wlast_i(cpu_i_wlast_i)
    ,.inport2_bready_i(cpu_i_bready_i)
    ,.inport2_arvalid_i(cpu_i_arvalid_i)
    ,.inport2_araddr_i(cpu_i_araddr_i)
    ,.inport2_arid_i(cpu_i_arid_i)
    ,.inport2_arlen_i(cpu_i_arlen_i)
    ,.inport2_arburst_i(cpu_i_arburst_i)
    ,.inport2_rready_i(cpu_i_rready_i)
    ,.inport3_awvalid_i(1'b0)
    ,.inport3_awaddr_i(32'b0)
    ,.inport3_awid_i(4'b0)
    ,.inport3_awlen_i(8'b0)
    ,.inport3_awburst_i(2'b0)
    ,.inport3_wvalid_i(1'b0)
    ,.inport3_wdata_i(32'b0)
    ,.inport3_wstrb_i(4'b0)
    ,.inport3_wlast_i(1'b0)
    ,.inport3_bready_i(1'b0)
    ,.inport3_arvalid_i(1'b0)
    ,.inport3_araddr_i(32'b0)
    ,.inport3_arid_i(4'b0)
    ,.inport3_arlen_i(8'b0)
    ,.inport3_arburst_i(2'b0)
    ,.inport3_rready_i(1'b0)
    ,.outport_awready_i(axi_retime_awready_w)
    ,.outport_wready_i(axi_retime_wready_w)
    ,.outport_bvalid_i(axi_retime_bvalid_w)
    ,.outport_bresp_i(axi_retime_bresp_w)
    ,.outport_bid_i(axi_retime_bid_w)
    ,.outport_arready_i(axi_retime_arready_w)
    ,.outport_rvalid_i(axi_retime_rvalid_w)
    ,.outport_rdata_i(axi_retime_rdata_w)
    ,.outport_rresp_i(axi_retime_rresp_w)
    ,.outport_rid_i(axi_retime_rid_w)
    ,.outport_rlast_i(axi_retime_rlast_w)

    // Outputs
    ,.inport0_awready_o(debug_awready_o)
    ,.inport0_wready_o(debug_wready_o)
    ,.inport0_bvalid_o(debug_bvalid_o)
    ,.inport0_bresp_o(debug_bresp_o)
    ,.inport0_bid_o(debug_bid_o)
    ,.inport0_arready_o(debug_arready_o)
    ,.inport0_rvalid_o(debug_rvalid_o)
    ,.inport0_rdata_o(debug_rdata_o)
    ,.inport0_rresp_o(debug_rresp_o)
    ,.inport0_rid_o(debug_rid_o)
    ,.inport0_rlast_o(debug_rlast_o)
    ,.inport1_awready_o(axi_dist_awready_w)
    ,.inport1_wready_o(axi_dist_wready_w)
    ,.inport1_bvalid_o(axi_dist_bvalid_w)
    ,.inport1_bresp_o(axi_dist_bresp_w)
    ,.inport1_bid_o(axi_dist_bid_w)
    ,.inport1_arready_o(axi_dist_arready_w)
    ,.inport1_rvalid_o(axi_dist_rvalid_w)
    ,.inport1_rdata_o(axi_dist_rdata_w)
    ,.inport1_rresp_o(axi_dist_rresp_w)
    ,.inport1_rid_o(axi_dist_rid_w)
    ,.inport1_rlast_o(axi_dist_rlast_w)
    ,.inport2_awready_o(cpu_i_awready_o)
    ,.inport2_wready_o(cpu_i_wready_o)
    ,.inport2_bvalid_o(cpu_i_bvalid_o)
    ,.inport2_bresp_o(cpu_i_bresp_o)
    ,.inport2_bid_o(cpu_i_bid_o)
    ,.inport2_arready_o(cpu_i_arready_o)
    ,.inport2_rvalid_o(cpu_i_rvalid_o)
    ,.inport2_rdata_o(cpu_i_rdata_o)
    ,.inport2_rresp_o(cpu_i_rresp_o)
    ,.inport2_rid_o(cpu_i_rid_o)
    ,.inport2_rlast_o(cpu_i_rlast_o)
    ,.inport3_awready_o()
    ,.inport3_wready_o()
    ,.inport3_bvalid_o()
    ,.inport3_bresp_o()
    ,.inport3_bid_o()
    ,.inport3_arready_o()
    ,.inport3_rvalid_o()
    ,.inport3_rdata_o()
    ,.inport3_rresp_o()
    ,.inport3_rid_o()
    ,.inport3_rlast_o()
    ,.outport_awvalid_o(axi_retime_awvalid_w)
    ,.outport_awaddr_o(axi_retime_awaddr_w)
    ,.outport_awid_o(axi_retime_awid_w)
    ,.outport_awlen_o(axi_retime_awlen_w)
    ,.outport_awburst_o(axi_retime_awburst_w)
    ,.outport_wvalid_o(axi_retime_wvalid_w)
    ,.outport_wdata_o(axi_retime_wdata_w)
    ,.outport_wstrb_o(axi_retime_wstrb_w)
    ,.outport_wlast_o(axi_retime_wlast_w)
    ,.outport_bready_o(axi_retime_bready_w)
    ,.outport_arvalid_o(axi_retime_arvalid_w)
    ,.outport_araddr_o(axi_retime_araddr_w)
    ,.outport_arid_o(axi_retime_arid_w)
    ,.outport_arlen_o(axi_retime_arlen_w)
    ,.outport_arburst_o(axi_retime_arburst_w)
    ,.outport_rready_o(axi_retime_rready_w)
);


soc_axi_dist
u_dist
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(cpu_d_awvalid_i)
    ,.inport_awaddr_i(cpu_d_awaddr_i)
    ,.inport_awid_i(cpu_d_awid_i)
    ,.inport_awlen_i(cpu_d_awlen_i)
    ,.inport_awburst_i(cpu_d_awburst_i)
    ,.inport_wvalid_i(cpu_d_wvalid_i)
    ,.inport_wdata_i(cpu_d_wdata_i)
    ,.inport_wstrb_i(cpu_d_wstrb_i)
    ,.inport_wlast_i(cpu_d_wlast_i)
    ,.inport_bready_i(cpu_d_bready_i)
    ,.inport_arvalid_i(cpu_d_arvalid_i)
    ,.inport_araddr_i(cpu_d_araddr_i)
    ,.inport_arid_i(cpu_d_arid_i)
    ,.inport_arlen_i(cpu_d_arlen_i)
    ,.inport_arburst_i(cpu_d_arburst_i)
    ,.inport_rready_i(cpu_d_rready_i)
    ,.outport_awready_i(axi_dist_awready_w)
    ,.outport_wready_i(axi_dist_wready_w)
    ,.outport_bvalid_i(axi_dist_bvalid_w)
    ,.outport_bresp_i(axi_dist_bresp_w)
    ,.outport_bid_i(axi_dist_bid_w)
    ,.outport_arready_i(axi_dist_arready_w)
    ,.outport_rvalid_i(axi_dist_rvalid_w)
    ,.outport_rdata_i(axi_dist_rdata_w)
    ,.outport_rresp_i(axi_dist_rresp_w)
    ,.outport_rid_i(axi_dist_rid_w)
    ,.outport_rlast_i(axi_dist_rlast_w)
    ,.outport_peripheral0_awready_i(soc_awready_i)
    ,.outport_peripheral0_wready_i(soc_wready_i)
    ,.outport_peripheral0_bvalid_i(soc_bvalid_i)
    ,.outport_peripheral0_bresp_i(soc_bresp_i)
    ,.outport_peripheral0_arready_i(soc_arready_i)
    ,.outport_peripheral0_rvalid_i(soc_rvalid_i)
    ,.outport_peripheral0_rdata_i(soc_rdata_i)
    ,.outport_peripheral0_rresp_i(soc_rresp_i)

    // Outputs
    ,.inport_awready_o(cpu_d_awready_o)
    ,.inport_wready_o(cpu_d_wready_o)
    ,.inport_bvalid_o(cpu_d_bvalid_o)
    ,.inport_bresp_o(cpu_d_bresp_o)
    ,.inport_bid_o(cpu_d_bid_o)
    ,.inport_arready_o(cpu_d_arready_o)
    ,.inport_rvalid_o(cpu_d_rvalid_o)
    ,.inport_rdata_o(cpu_d_rdata_o)
    ,.inport_rresp_o(cpu_d_rresp_o)
    ,.inport_rid_o(cpu_d_rid_o)
    ,.inport_rlast_o(cpu_d_rlast_o)
    ,.outport_awvalid_o(axi_dist_awvalid_w)
    ,.outport_awaddr_o(axi_dist_awaddr_w)
    ,.outport_awid_o(axi_dist_awid_w)
    ,.outport_awlen_o(axi_dist_awlen_w)
    ,.outport_awburst_o(axi_dist_awburst_w)
    ,.outport_wvalid_o(axi_dist_wvalid_w)
    ,.outport_wdata_o(axi_dist_wdata_w)
    ,.outport_wstrb_o(axi_dist_wstrb_w)
    ,.outport_wlast_o(axi_dist_wlast_w)
    ,.outport_bready_o(axi_dist_bready_w)
    ,.outport_arvalid_o(axi_dist_arvalid_w)
    ,.outport_araddr_o(axi_dist_araddr_w)
    ,.outport_arid_o(axi_dist_arid_w)
    ,.outport_arlen_o(axi_dist_arlen_w)
    ,.outport_arburst_o(axi_dist_arburst_w)
    ,.outport_rready_o(axi_dist_rready_w)
    ,.outport_peripheral0_awvalid_o(soc_awvalid_o)
    ,.outport_peripheral0_awaddr_o(soc_awaddr_o)
    ,.outport_peripheral0_wvalid_o(soc_wvalid_o)
    ,.outport_peripheral0_wdata_o(soc_wdata_o)
    ,.outport_peripheral0_wstrb_o(soc_wstrb_o)
    ,.outport_peripheral0_bready_o(soc_bready_o)
    ,.outport_peripheral0_arvalid_o(soc_arvalid_o)
    ,.outport_peripheral0_araddr_o(soc_araddr_o)
    ,.outport_peripheral0_rready_o(soc_rready_o)
);



endmodule
