SOURCES=$(shell find src -name "*.asm")
OBJECTS:=$(SOURCES:src/%.asm=build/%.o)
EXECUTABLE=ulam

ASFLAGS=-mmnemonic=intel -msyntax=intel -mnaked-reg -I src

all: dist/$(EXECUTABLE)

debug: ASFLAGS += -g
debug: dist/$(EXECUTABLE)

dist/$(EXECUTABLE): $(OBJECTS) $(PARSEO)
	@mkdir -p dist
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@

build:
	find src -type d -print0 | sed 's/src/build/g' | xargs -0 mkdir -p

build/%.o: src/%.asm | build
	$(AS) $(ASFLAGS) $< -o $@


clean: FORCE
	rm -rf build

rmdist: FORCE
	rm -rf dist/*

FORCE:
