## Clock signal
set_property -dict { PACKAGE_PIN J19    IOSTANDARD LVCMOS33 } [get_ports { clk100_i }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk100_i }];

set_property INTERNAL_VREF 0.750 [get_iobanks 35]

## RGB LEDs
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { led0_r_o }];
set_property -dict { PACKAGE_PIN Y1    IOSTANDARD LVCMOS33 } [get_ports { led0_g_o }];
set_property -dict { PACKAGE_PIN W1    IOSTANDARD LVCMOS33 } [get_ports { led0_b_o }];
set_property -dict { PACKAGE_PIN AA1   IOSTANDARD LVCMOS33 } [get_ports { led1_r_o }];
set_property -dict { PACKAGE_PIN AB1   IOSTANDARD LVCMOS33 } [get_ports { led1_g_o }];
set_property -dict { PACKAGE_PIN Y2    IOSTANDARD LVCMOS33 } [get_ports { led1_b_o }];

## UART Interface (CN14)
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { uart_tx_o }];
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { uart_rx_i }];

## SPI Flash
set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { flash_cs_o }];
set_property -dict { PACKAGE_PIN P22   IOSTANDARD LVCMOS33 } [get_ports { flash_mosi_o }];
set_property -dict { PACKAGE_PIN R22   IOSTANDARD LVCMOS33 } [get_ports { flash_miso_i }];

# USB switch
set_property PACKAGE_PIN Y8 [get_ports ulpi_sw_s]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi_sw_s]
set_property PACKAGE_PIN Y9 [get_ports ulpi_sw_oe_n]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi_sw_oe_n]

# ULPI Interface (USB Host)
set_property PACKAGE_PIN W19 [get_ports ulpi0_clk60_i]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi0_clk60_i]
set_property PACKAGE_PIN AB18 [get_ports {ulpi0_data_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[0]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[0]}]
set_property PACKAGE_PIN AA18 [get_ports {ulpi0_data_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[1]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[1]}]
set_property PACKAGE_PIN AA19 [get_ports {ulpi0_data_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[2]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[2]}]
set_property PACKAGE_PIN AB20 [get_ports {ulpi0_data_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[3]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[3]}]
set_property PACKAGE_PIN AA20 [get_ports {ulpi0_data_io[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[4]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[4]}]
set_property PACKAGE_PIN AB21 [get_ports {ulpi0_data_io[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[5]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[5]}]
set_property PACKAGE_PIN AA21 [get_ports {ulpi0_data_io[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[6]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[6]}]
set_property PACKAGE_PIN AB22 [get_ports {ulpi0_data_io[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ulpi0_data_io[7]}]
set_property SLEW FAST [get_ports {ulpi0_data_io[7]}]
set_property PACKAGE_PIN W21 [get_ports ulpi0_dir_i]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi0_dir_i]
set_property PACKAGE_PIN Y22 [get_ports ulpi0_stp_o]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi0_stp_o]
set_property SLEW FAST [get_ports ulpi0_stp_o]
set_property PACKAGE_PIN W22 [get_ports ulpi0_nxt_i]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi0_nxt_i]
set_property PACKAGE_PIN V20 [get_ports ulpi0_reset_o]
set_property IOSTANDARD LVCMOS33 [get_ports ulpi0_reset_o]
set_property SLEW FAST [get_ports ulpi0_reset_o]

create_clock -period 16.667 -name ulpi0_clk -add [get_ports ulpi0_clk60_i]
set_clock_groups -name ulpi0_clk_grp -asynchronous -group [get_clocks ulpi0_clk]

set_clock_groups -name clk_w_grp -asynchronous -group [get_clocks clk_w]

# ULPI Interface (USB Device)
#set_property PACKAGE_PIN V4 [get_ports ulpi1_clk60_i]
#set_property IOSTANDARD LVCMOS33 [get_ports ulpi1_clk60_i]
#set_property PACKAGE_PIN AB2 [get_ports {ulpi1_data_io[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[0]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[0]}]
#set_property PACKAGE_PIN AA3 [get_ports {ulpi1_data_io[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[1]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[1]}]
#set_property PACKAGE_PIN AB3 [get_ports {ulpi1_data_io[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[2]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[2]}]
#set_property PACKAGE_PIN Y4 [get_ports {ulpi1_data_io[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[3]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[3]}]
#set_property PACKAGE_PIN AA4 [get_ports {ulpi1_data_io[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[4]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[4]}]
#set_property PACKAGE_PIN AB5 [get_ports {ulpi1_data_io[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[5]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[5]}]
#set_property PACKAGE_PIN AA5 [get_ports {ulpi1_data_io[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[6]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[6]}]
#set_property PACKAGE_PIN AB6 [get_ports {ulpi1_data_io[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ulpi1_data_io[7]}]
#set_property SLEW FAST [get_ports {ulpi1_data_io[7]}]
#set_property PACKAGE_PIN AB7 [get_ports ulpi1_dir_i]
#set_property IOSTANDARD LVCMOS33 [get_ports ulpi1_dir_i]
#set_property PACKAGE_PIN AA6 [get_ports ulpi1_stp_o]
#set_property IOSTANDARD LVCMOS33 [get_ports ulpi1_stp_o]
#set_property SLEW FAST [get_ports ulpi1_stp_o]
#set_property PACKAGE_PIN AB8 [get_ports ulpi1_nxt_i]
#set_property IOSTANDARD LVCMOS33 [get_ports ulpi1_nxt_i]
#set_property PACKAGE_PIN AA8 [get_ports ulpi1_reset_o]
#set_property IOSTANDARD LVCMOS33 [get_ports ulpi1_reset_o]
#set_property SLEW FAST [get_ports ulpi1_reset_o]
#
#create_clock -period 16.667 -name ulpi1_clk -add [get_ports ulpi1_clk60_i]
#set_clock_groups -name ulpi1_clk_grp -asynchronous -group [get_clocks ulpi1_clk]