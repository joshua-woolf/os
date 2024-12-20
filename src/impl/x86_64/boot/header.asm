section .multiboot_header
header_start:
	; Multiboot2 magic number
	dd 0xe85250d6
	; Specify architecture is protected mode i386
	dd 0
	; Calculate header length
	dd header_end - header_start
	; Calculate Checksum
	dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))
	; Specify end tag
	dw 0
	dw 0
	dd 8
header_end:
