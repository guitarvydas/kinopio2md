convert Kinopio mind-map to markdown

# Install
$ ln -s ..../od/od ./od


0. begin with kinopio drawing "test" which contains cards and connections between cards
0. export to "test.json"

1. cull the json file, leaving only semantic information
   - cards
	 - id
	 - name
   - connections
	 - id
	 - from (card id)
	 - to   (card id)
	 - connectionType (used to determine whether the connection is indentation or footnote)

2. Transpile semantic information to PROLOG
3. Generate markdown from semantic information using SWIPL (PROLOG) using 'content.pl' and 'md.pl'

# TODO:
- check that all outputs are distinct
  - my code had a case where I had 2 outputs called "output" and this caused mysterious bugs instead of failure

# Directories and Files for odin0D
*[see odin0d repo for details]*

- `0d/`
- `leaf0d/`
- `process/`
- `registry0d/`
- `syntax/`

- `(debug/)`

# Directories and Files for kinopio2md
- `doc/
- `ohmjs/`
- `rwr/`
- `ai/`
- `feedback/`
- `kinopio2md.dSYM/`
- `kjson/`
- `rt/`
- `cards.ohm`, `cards.rwr`
- `cull.py`
- `gen.bash`
	- .bash script that runs swipl on md.pl manually
- `kinopio2md`
- `main.odin`
- `Makefile`
- `md.pl`
- `README.md`
- `support.js`
	- JavaScript file that is prepended to all files transpiled from `.rwr`
	- currently "empty" (contains "empty" JS namespace), since no support functions are needed
- `top.drawio`
	- main code for kinopio2.md (code written as diagrams)


- `play/`
	- directory containing various manual tests and Proofs of Concept
	- ignore
- `attic/`
	- files not used, that I want to keep
	- ignore
- `junk.*`
	- ignore all of these files
	- intermediate temp files during debugging

