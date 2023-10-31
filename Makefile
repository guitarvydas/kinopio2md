ODIN_FLAGS ?= -debug -o:none

all: dev

dev: diagram

diagram:
	rm -f kinopio2md
	odin run . $(ODIN_FLAGS)

