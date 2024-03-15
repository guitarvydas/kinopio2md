# convert kinopio JSON file to markdown
- the intention is to use an LLM to convert Kinopio "spaces" and "cards" to markdown, then use an LLM to convert the markdown into prose
- still WIP
- user must: export a Kinopio "space" to JSON, then run kinopio2md on the JSON to produce a markdown file
  - ATM, this tool stops after generating markdown, hence, the user must copy/paste the markdown into an LLM to proceed
  - e.g. use ChatGPT
- the Kinopio format, for now, is:
  - cards containing brief points in text (only) form
  - connections between cards - currently every connection is treated the same, regardless of Kinopio connection type
  - the connections are used to infer markdown nesting of points
  - the inferencing is currently done with Prolog, although the inferencing is fairly simple and could be done in any other programming language (using, say, loops within loops)
  
- step 1 is to encode whitespace in the JSON strings into printable ASCII/Unicode, to allow subsequent passes to use OhmJS "syntactic" rules (syntactic rules have a more convenient syntax, but, they skip over whitespace which poses problems if the input contains words separated by whitespace only, instead of - say - commas)

- since Kinopio produces JSON, we can use `jq` to extract the interesting fields from Kinopio's markdown, thus, reducing the overhead of processing every little detail produced by Kinopio
