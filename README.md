# Projects based on LambaConcept USB2Sniffer Artix 7 FPGA board

Github: [https://github.com/ultraembedded/projects_usb2sniffer](https://github.com/ultraembedded/projects_usb2sniffer)

## Intro
This repo contains various projects for the LambaConcept USB2Sniffer FPGA board.
![USB2Sniffer](docs/usb2sniffer_board.jpg)

The board is available for purchase on the LambdaConcept shop;
[https://shop.lambdaconcept.com/home/35-usb2-sniffer.html](https://shop.lambdaconcept.com/home/35-usb2-sniffer.html)

The USB2Sniffer is designed to be a USB 2.0 capture device, or a development board for USB 2.0 IP designs.

**However, it can also be used as a SBC for running RISC-V Linux with both USB 2.0 host and USB 2.0 device support!**

## HW Features
* XC7A35T Artix 7 Series FPGA [xc7a35t-fgg484-1](docs/xc7a35tfgg484.txt)
* 256MB DDR3 [Micron MT41K256M16TW-107](https://www.micron.com/-/media/client/global/documents/products/data-sheet/dram/ddr3/4gb_ddr3l.pdf)
* 32MB SPI Flash [Micron MT25QL256ABA](https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_l_256_aba_0.pdf?rev=fa4e5a6703ba4910a5286cecad7e52db)
* USB3.0 to FIFO Bridge (up to 400MB/s of bandwidth to the FPGA) [FTDI FT601](https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT600Q-FT601Q%20IC%20Datasheet.pdf)
* 2 x High Speed USB2.0 ULPI PHY [Microchip USB3300](http://ww1.microchip.com/downloads/en/DeviceDoc/00001783C.pdf)

## Getting Started

#### Cloning

To clone this project and its dependencies;

```
git clone --recursive https://github.com/ultraembedded/projects_usb2sniffer.git

```
