SRC=src
ODIN_FLAGS ?= -debug -o:none
LIBSRC=../0d/libsrc
0D=../0d/0d/odin/0d/*.odin
STD=../0d/0d/odin/std/*.odin
D2Jsrc=../0d/0d/odin/das2json/*.odin
D2J=../0d/0d/odin/das2json/das2json

all: dev

#dev: $(SRC)/top.drawio main.odin 0Dstuff
dev: $(SRC)/top.drawio main.odin clean
	odin build . $(ODIN_FLAGS)
	$(D2J) $(SRC)/top.drawio
	$(D2J) $(LIBSRC)/transpile.drawio
	./kinopio2md main $(SRC)/top.drawio $(LIBSRC)/transpile.drawio

0Dstuff: $(0D) $(STD) $(D2Jsrc)
	echo "0D needs to be rebuilt"
	exit 1

clean:
	rm -rf kinopio2md kinopio2md.dSYM
	rm -f kinopio2md content.pl
	rm -f /tmp/fakepipename*

