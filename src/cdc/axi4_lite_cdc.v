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

module axi4_lite_cdc
(
    // Inputs
     input           wr_clk_i
    ,input           wr_rst_i
    ,input           inport_awvalid_i
    ,input  [ 31:0]  inport_awaddr_i
    ,input           inport_wvalid_i
    ,input  [ 31:0]  inport_wdata_i
    ,input  [  3:0]  inport_wstrb_i
    ,input           inport_bready_i
    ,input           inport_arvalid_i
    ,input  [ 31:0]  inport_araddr_i
    ,input           inport_rready_i
    ,input           rd_clk_i
    ,input           rd_rst_i
    ,input           outport_awready_i
    ,input           outport_wready_i
    ,input           outport_bvalid_i
    ,input  [  1:0]  outport_bresp_i
    ,input           outport_arready_i
    ,input           outport_rvalid_i
    ,input  [ 31:0]  outport_rdata_i
    ,input  [  1:0]  outport_rresp_i

    // Outputs
    ,output          inport_awready_o
    ,output          inport_wready_o
    ,output          inport_bvalid_o
    ,output [  1:0]  inport_bresp_o
    ,output          inport_arready_o
    ,output          inport_rvalid_o
    ,output [ 31:0]  inport_rdata_o
    ,output [  1:0]  inport_rresp_o
    ,output          outport_awvalid_o
    ,output [ 31:0]  outport_awaddr_o
    ,output          outport_wvalid_o
    ,output [ 31:0]  outport_wdata_o
    ,output [  3:0]  outport_wstrb_o
    ,output          outport_bready_o
    ,output          outport_arvalid_o
    ,output [ 31:0]  outport_araddr_o
    ,output          outport_rready_o
);




`ifndef verilator
axilite_cdc_buffer
u_core
(
    .s_axi_aclk(wr_clk_i), 
    .s_axi_aresetn(~wr_rst_i), 

    .s_axi_awaddr(inport_awaddr_i), 
    .s_axi_awprot(3'b0), 
    .s_axi_awvalid(inport_awvalid_i),
    .s_axi_wdata(inport_wdata_i), 
    .s_axi_wstrb(inport_wstrb_i), 
    .s_axi_wvalid(inport_wvalid_i),
    .s_axi_bready(inport_bready_i),
    .s_axi_rready(inport_rready_i), 
    .s_axi_araddr(inport_araddr_i),
    .s_axi_arprot(3'b0),
    .s_axi_arvalid(inport_arvalid_i), 

    .s_axi_arready(inport_arready_o), 
    .s_axi_awready(inport_awready_o), 
    .s_axi_wready(inport_wready_o),     
    .s_axi_rdata(inport_rdata_o), 
    .s_axi_rresp(inport_rresp_o), 
    .s_axi_rvalid(inport_rvalid_o), 
    .s_axi_bresp(inport_bresp_o), 
    .s_axi_bvalid(inport_bvalid_o),     

    .m_axi_aclk(rd_clk_i),
    .m_axi_aresetn(~rd_rst_i),

    .m_axi_awaddr(outport_awaddr_o),
    .m_axi_awprot(),
    .m_axi_awvalid(outport_awvalid_o),
    .m_axi_awready(outport_awready_i),
    .m_axi_wdata(outport_wdata_o),
    .m_axi_wstrb(outport_wstrb_o),
    .m_axi_wvalid(outport_wvalid_o), 
    .m_axi_wready(outport_wready_i),
    .m_axi_bresp(outport_bresp_i),
    .m_axi_bvalid(outport_bvalid_i),
    .m_axi_bready(outport_bready_o),
    .m_axi_araddr(outport_araddr_o), 
    .m_axi_arprot(), 
    .m_axi_arvalid(outport_arvalid_o),
    .m_axi_arready(outport_arready_i),
    .m_axi_rdata(outport_rdata_i), 
    .m_axi_rresp(outport_rresp_i),
    .m_axi_rvalid(outport_rvalid_i),
    .m_axi_rready(outport_rready_o)
);
`endif

endmodule
