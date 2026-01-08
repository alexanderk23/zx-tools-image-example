			device zxspectrum48

			org $4000
unpacked		incbin <BUILD_DIR/main.bin>
.size			equ $-unpacked

			IFDEF TRD_NAME
			org $5d3b
			ELSE
			org $5ccb
			ENDIF
basic			dw 0, start-basic-8, $c0ec, $0e30, 0, start, $0d00: db $ff
start			di: ld sp, .sp
			ld hl, packed + packed.size - 1
			ld de, START_ADDR + unpacked.size - 1
			ld bc, START_ADDR
.sp			equ $-2

unpacker		include "dzx0_standard_back.asm"

packed			incbin <BUILD_DIR/main.bin.zx0b>
.size			equ $-packed

			IFDEF TAP_NAME
			emptytap <TAP_NAME>
			savetap <TAP_NAME>, BASIC, <PROJECT_NAME>, basic, $-basic, 0, 0
			ENDIF

			IFDEF TRD_NAME
			emptytrd <TRD_NAME>, <PROJECT_NAME>
			savetrd <TRD_NAME>, "boot.B", basic, $-basic
			ENDIF
