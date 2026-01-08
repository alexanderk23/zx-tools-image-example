			device zxspectrum128
			page 0

ISR_TAB			equ $8000
ISR_ADDR		equ ((((HIGH ISR_TAB + 1) << 8)) | (HIGH ISR_TAB + 1))

			org ISR_TAB-3
ep			jp start
			ds 257, HIGH ISR_ADDR

			org ISR_ADDR
isr			push af, bc, de, hl, ix, iy
			exx: exa: push af, bc, de, hl

			call pt3player.play

			pop hl, de, bc, af: exa: exx
			pop iy, ix, hl, de, bc, af
			ei: ret

fadeout			ld hl, $8000: ld de, $3807: ld b, $08
.l1			ld a, l: and d: jr z, .l2: sub b
.l2			ld c, a: ld a, l: and e: jr z, .l3: dec a
.l3			or c: ld (hl), a: inc l: jr nz, .l1: ld d, h
.step			ld h, $58: ld c, $03: ld e, (hl): ld a, (de)
			.3 rra: and $07: halt: out ($fe), a
.loop			ld e, (hl): ld a, (de): ld (hl), a: inc l: jp nz, .loop
			inc h: dec c: jr nz, .loop: djnz .step
			ret

start			ld a, HIGH ISR_TAB: ld i, a: im 2
			ld hl, music: call pt3player.init
			ei: call fadeout

			ld hl, screen: ld de, $4000: ld bc, 6144: ldir
			halt: ld bc, 768: ldir

loop			halt: jr loop

			include "pt3player.asm"
music			incbin "assets/music.pt3"	; https://zxart.ee/eng/authors/n/nq/deltas-shadow---alien-3-nes-title-theme/
screen			incbin "assets/screen.scr"	; https://zxart.ee/eng/authors/letter20332/ooo/alien31/

			IFDEF SNA_NAME
			savesna <SNA_NAME>, start
			ELSE
			savebin <BUILD_DIR/main.bin>, ep, $-ep
			ENDIF
