SRC=src
ODIN_FLAGS ?= -debug -o:none
0D=process/*.odin 0d/*.odin leaf0d/*.odin debug/*.odin process/*.odin
D2J=das2json/das2json

all: dev

dev: $(SRC)/top.drawio $(D2J) main.odin
	rm -f kinopio2md content.pl
	rm -f /tmp/fakepipename*
	odin run . $(ODIN_FLAGS)

das2json: ../das2json/das2json
	@echo 'building...'
	(cd ../das2json ; make)

