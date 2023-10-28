ODIN_FLAGS ?= -debug -o:none

all: dev

dev:
	rm -f top
	odin run . $(ODIN_FLAGS)

