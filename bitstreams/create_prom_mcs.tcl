 write_cfgmem -force -format MCS -size 32 -interface SPIx1 -loadbit "up 0x0 fpga.bit" -loaddata "up 0x300000 primary_boot.bin up 0x400000 secondary_boot.bin up 0x500000 config.dtb up 0x600000 vmlinux.bin" riscv_sbc.mcs
 quit
