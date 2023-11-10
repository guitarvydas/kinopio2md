# Overview of Kinopio2md

The goal of Kinopio2md is to convert "cards" into indented, point-form markdown.  The markdown is intended to be pasted into ChatGPT for conversion to paragraphs of prose (instead of point-form).

For example, the following Kinopio "page" ...
![[Screenshot 2023-10-29 at 10.24.11 PM.png]]
... is converted to:
```
control flow is not data
- control flow is _interpretation_ of data - dynamic flow
    - a CPU is an interpreter
        - a CPU interprets _opcodes_
        - a CPU interprets _opcodes_ so quickly that we think of it as something other than interpretation
- data is _static_ - and is not interpreted by the underlying system
    - static data is interpreted by the _program_, not the CPU
```

Kinopio is a tool which allows the user to create "cards" containing bits of text (<= 300 characters) and to connect such cards by visible, directional lines whose meaning is unspecified.  Kinopio allows users to create digital gardens and "mind maps" without getting in the way (a problem that most mind-mapping tools have).

Kinopio "cards" and "connections" are rendered on web pages, called "spaces".

Single pages can be exported as downloadable JSON data.  The data contains information on how the cards are rendered by the Kinopio tool, along with the bits of text, along with a description of each "connection".

Kinopio2md assumes that each page is a *tree* of interrelated information, with the cards being nodes in the tree and connections between nodes specified by Kinopio, being tree-branches.  At present, we simply assume that *all* Kinopio connections represent tree branches.  Later, when the tool has been debugged, we might wish to ascribe different meanings to the various types of Kinopio connections, for example, maybe `"connectionTypeId":"gH2uKbIRws6FMCtnp5XND"` will be taken to mean *branch*, whereas `"connectionTypeId":"...???..."` will mean *footnote*, etc.

The intention is to paste the markdown into ChatGPT after priming with the prompt "summarize the following markdown as a subsection for a chapter in a book".  ChatGPT will rewrite the point-form into prose form.

# Initial (Experimental) Design

![[top level.png]]
The experimental Design of kinopio2md consists of 6 stages:
1. Read Text File
2. Escape Whitespace
3. Extract Semantic Information
4. Transpile Cards to PROLOG
5. Generate Markdown
6. Unescape Whitespace

We want to convert JSON Kinopio cards to Prolog facts, then run a small Prolog program `md.pl` to search through the facts and to rearrange the text contained in the facts to look like markdown. 