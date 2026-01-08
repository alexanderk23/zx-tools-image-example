PROJECT_NAME	?= example

BUILD_DIR	?= build

MKDIR		?= mkdir -p
ASM		?= sjasmplus --syntax=F --msg=war -DPROJECT_NAME=$(PROJECT_NAME) -DBUILD_DIR=$(BUILD_DIR)
ZX0		?= zx0 -f

TAP = $(PROJECT_NAME).tap
TRD = $(PROJECT_NAME).trd
SCL = $(PROJECT_NAME).scl
SNA = $(PROJECT_NAME).sna

.PHONY: clean all sna tap trd scl

all: sna tap trd
sna: $(SNA)
tap: $(TAP)
trd: $(TRD)
scl: $(SCL)

clean:
	$(RM) $(SNA) $(TAP) $(TRD) $(SCL) $(ZIP)
	$(RM) -r $(BUILD_DIR)

%.scl: %.trd
	trd2scl $< $@

%.zx0: %
	$(ZX0) $< $@

%.zx0b: %
	$(ZX0) -b -q $< $@

$(BUILD_DIR)/main.bin: src/$(PROJECT_NAME).asm | $(BUILD_DIR) src/*.asm assets/*
	$(ASM) $<

$(BUILD_DIR):
	$(MKDIR) $@

$(SNA): src/$(PROJECT_NAME).asm | src/*.asm assets/*
	$(ASM) -DSNA_NAME=$@ $<

$(TAP): src/loader.asm | $(BUILD_DIR)/main.bin.zx0b
	$(ASM) -DSTART_ADDR=0x7ffd -DTAP_NAME=$@ $<

$(TRD): src/loader.asm | $(BUILD_DIR)/main.bin.zx0b
	$(ASM) -DSTART_ADDR=0x7ffd -DTRD_NAME=$@ $<
