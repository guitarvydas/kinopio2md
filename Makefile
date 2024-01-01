SRC=src
ODIN_FLAGS ?= -debug -o:none
0D=0d/*.odin
D2J=das2json/das2json

all: dev

dev: $(SRC)/top.drawio $(D2J) main.odin $(0D)
	rm -f kinopio2md content.pl
	rm -f /tmp/fakepipename*
	odin run . $(ODIN_FLAGS)

das2json: das2json/das2json $(0D)
	@echo 'building...'
	(cd das2json ; make)

