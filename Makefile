ODIN_FLAGS ?= -debug -o:none

all: dev

dev:
	@echo 'run swipl manually, consult(md), main.'

diagram:
	rm -f kinopio2md
	odin run . $(ODIN_FLAGS)

