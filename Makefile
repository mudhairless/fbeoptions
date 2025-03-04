COMPILER = fbc
COMPILE_OPTS = -i inc -g -w all -exx
LINK_OPTS = -lib
TEST_COMPILE_OPTS = -i inc -p lib -g -w all -exx
EXE_EXT = .exe

all: lib/libfbeoptions.a examples

%.o: %.bas inc/options.bi
	$(COMPILER) $(COMPILE_OPTS) -c $< -o $@

examples: examples/cmdopt${EXE_EXT}

examples/cmdopt${EXE_EXT}: lib/libfbeoptions.a examples/cmdopt.bas
	$(COMPILER) $(TEST_COMPILE_OPTS) examples/cmdopt.bas

lib/libfbeoptions.a: src/option.o src/parser.o
	$(COMPILER) $(LINK_OPTS) -x lib/libfbeoptions.a src/option.o src/parser.o

clean:
	rm src/*.o lib/*.a examples/cmdopt${EXE_EXT}

.PHONY: clean
