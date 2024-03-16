LIBSRC=0D/odin/std
ODIN_FLAGS ?= -debug -o:none
D2J=0d/das2json/das2json

dev: dev-full

# it is a good idea to run roots-only to check that the arrows in the drawing are all going in the right direction
# one check is to look at the list of roots - if there are too many, then it means that something is probably wrong with the diagram
# do this check before you do a full run
dev-check: clean check

dev-full: clean run

# ... leave original for bug report ...
# run: kinopio2md transpile.drawio.json
# 	./kinopio2md "tests/Why Do We Need Data Structures.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio

# check: kinopio2md transpile.drawio.json
# 	./kinopio2md "tests/Why Do We Need Data Structures.json" check-main kinopio2md.drawio $(LIBSRC)/transpile.drawio

run: kinopio2md transpile.drawio.json
	./kinopio2md "tests/copywdwnds.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio
	./kinopio2md "tests/copywdwnds.json" check-main kinopio2md.drawio $(LIBSRC)/transpile.drawio

check: kinopio2md transpile.drawio.json
	./kinopio2md "tests/copywdwnds.json" check-main kinopio2md.drawio $(LIBSRC)/transpile.drawio

run-4: kinopio2md transpile.drawio.json
	./kinopio2md "tests/t4.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio

run-test-1: kinopio2md transpile.drawio.json
	./kinopio2md "tests/SWEngineering and SWImplementation.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio

kinopio2md: kinopio2md.drawio.json
	odin build . $(ODIN_FLAGS)

kinopio2md.drawio.json: kinopio2md.drawio transpile.drawio.json
	$(D2J) kinopio2md.drawio

transpile.drawio.json: $(LIBSRC)/transpile.drawio
	$(D2J) $(LIBSRC)/transpile.drawio

clean:
	rm -rf kinopio2md kinopio2md.dSYM *~ *.json


# debugging

run-twdwnds: kinopio2md transpile.drawio.json
	./kinopio2md "tests/twdwnds.json" main kinopio2md.drawio $(LIBSRC)/transpile.drawio

roots-only-twdwnds: kinopio2md transpile.drawio.json
	./kinopio2md "tests/twdwnds.json" roots-main kinopio2md.drawio $(LIBSRC)/transpile.drawio


