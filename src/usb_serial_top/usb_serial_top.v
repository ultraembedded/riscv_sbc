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
module usb_serial_top
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
    parameter BAUDRATE         = 1000000
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
      output          uart_rx_o
    , input           uart_tx_i

    // ULPI Interface
    , output          ulpi_reset_o
    , inout [7:0]     ulpi_data_io
    , output          ulpi_stp_o
    , input           ulpi_nxt_i
    , input           ulpi_dir_i
    , input           ulpi_clk60_i
);

// USB clock / reset
wire usb_clk_w;
wire usb_rst_w;

wire clk_bufg_w;
IBUF u_ibuf ( .I(ulpi_clk60_i), .O(clk_bufg_w) );
BUFG u_bufg ( .I(clk_bufg_w),   .O(usb_clk_w) );

reset_gen
u_rst_usb
(
    .clk_i(usb_clk_w),
    .rst_o(usb_rst_w)
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
        .T(ulpi_dir_i),
        .I(ulpi_out_w[i]),
        .O(ulpi_in_w[i]),
        .IO(ulpi_data_io[i])
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
    .O(ulpi_stp_o)
);

// USB Core
usb_cdc_top
#( .BAUDRATE(BAUDRATE) )
u_usb
(
     .clk_i(usb_clk_w)
    ,.rst_i(usb_rst_w)

    // ULPI
    ,.ulpi_data_out_i(ulpi_in_w)
    ,.ulpi_dir_i(ulpi_dir_i)
    ,.ulpi_nxt_i(ulpi_nxt_i)
    ,.ulpi_data_in_o(ulpi_out_w)
    ,.ulpi_stp_o(ulpi_stp_w)

    ,.tx_i(uart_tx_i)
    ,.rx_o(uart_rx_o)
);

assign ulpi_reset_o = 1'b0;

endmodule
