global start

section .text
bits 32
start:
	; Print "OK"
	mov dword [0xb8000], 0x2f4b2f4f
	hlt
