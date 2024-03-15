LIBSRC=0D/odin/std
ODIN_FLAGS ?= -debug -o:none
D2J=0d/das2json/das2json

dev: clean run

run: kinopio2md transpile.drawio.json
	./kinopio2md "tests/SWEngineering and SWImplementation.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio

kinopio2md: kinopio2md.drawio.json
	odin build . $(ODIN_FLAGS)

kinopio2md.drawio.json: kinopio2md.drawio transpile.drawio.json
	$(D2J) kinopio2md.drawio

transpile.drawio.json: $(LIBSRC)/transpile.drawio
	$(D2J) $(LIBSRC)/transpile.drawio

clean:
	rm -rf kinopio2md kinopio2md.dSYM *~ *.json
