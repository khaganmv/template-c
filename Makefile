.PHONY: run clean valgrind

INCLUDEDIR = include
SRCDIR = src/*.c
BIN = out/main

MAINFLAGS     = -Werror -Wall -Wextra -Wuninitialized -Wshadow -Wundef -O1
CTRLFLOWFLAGS = -Winit-self -Wswitch-enum -Wswitch-default -Wformat=2 -Wformat-extra-args
ARITHFLAGS    = -Wfloat-equal -Wpointer-arith
CASTCONVFLAGS = -Wstrict-overflow=5 -Wcast-qual -Wcast-align -Wconversion -Wpacked
SANFLAGS      = -Wredundant-decls -Wmissing-declarations -Wmissing-field-initializers
SPECFLAGS     = -Wmissing-prototypes -Wstrict-prototypes -Wnested-externs

CFLAGS = $(MAINFLAGS) $(CTRLFLOWFLAGS) $(ARITHFLAGS) $(CASTCONVFLAGS) $(SANFLAGS) $(SPECFLAGS)

all: $(BIN)

$(BIN): $(SRCDIR)
	$(CC) $^ -o $@ -I$(INCLUDEDIR) $(CFLAGS)

run: all
	./$(BIN)

clean:
	rm -f out/*

valgrind: all
	valgrind --leak-check=full ./$(BIN)
