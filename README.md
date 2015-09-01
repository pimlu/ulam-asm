## ulam-asm

This is an Ulam spiral generator for Linux written in x86-64 assembly.

### Building
Chances are all you need to do is run `make`.  This should build on any system that has GNU binutils installed (most well-known Linux distros) or a compatible alternative.

### Running
The binary will be located at `dist/ulam`.  It takes two arguments, the width and the height.

### Debugging

To build with debugging symbols, run `make debug`.  You may have to `make clean` first, if it's already been built without `debug`.

### Stripping Symbols
To make a small binary with stripped symbols, run `make strip` after cleaning.  There is a `strip` branch which has some unnecessary bits removed to see how small it can be made.
