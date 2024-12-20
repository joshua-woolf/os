x86_64_asm_source_files := $(shell find src/impl/x86_64 -name *.asm)
x86_64_asm_object_files := $(patsubst src/impl/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))
image_name := os_builder

$(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@

.PHONY: build-x86_64
build-x86_64: $(x86_64_asm_object_files)
	mkdir -p dist/x86_64 && \
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T targets/x86_64/linker.ld $(x86_64_asm_object_files) && \
	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86_64/iso

.PHONY: docker-build
docker-build:
	docker build . -t $(image_name)

.PHONY: docker-run
docker-run:
	docker run --rm -it -v "$(PWD):/root/env" $(image_name) make build-x86_64

.PHONY: emulate
emulate:
	qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso -L /usr/share/qemu/

.PHONY: all
all: docker-build docker-run emulate

.PHONY: clean
clean:
	rm -rf build dist targets/x86_64/iso/boot/kernel.bin && \
	docker rmi $(image_name) -f
