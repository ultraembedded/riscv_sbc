TARGET_HELP+= "Help:\n"
all: help

TARGET_HELP += "make create_mcs   - Build a MCS file for the onboard SPI-Flash containing the bitstream and bootloaders.\n"
create_mcs:
	vivado -mode tcl -source create_prom_mcs.tcl

TARGET_HELP += "make clean        - Cleanup build files.\n"
clean:
	rm -rf riscv_sbc.*

help:
	@echo $(TARGET_HELP)