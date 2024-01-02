1. `Read Text File` is implemented in Odin code (leaf0d/leaf0d.odin:low_level_read_text_file_handle and leaf0d/leaf0d.odin:open_text_file_handle) for convenience and "efficiency".  This could be implemented in /bin/*sh or some other language, like Javascript, Python, etc., but, for arbitrary reasons wasn't implemented that way.

2. `Escape Whitespace` is implemented as a text transpiler using the `Rewriter` component and a grammar and a rewrite specification (`RWR`).  Regular Expressions (REGEX) and traditional CFG-based parsers could have been used, but, PEG / OhmJS is more powerful for this kind of thing. That power is demonstrated by this small component and by the `word` rule which allows spaces in names (as long as Unicode brackets are used.  The brackets can be nested.  We could have used this technique to implement nested comments, but, we used it only to show bracketed `word`s). The `Rewriter` lets us write a "macro processor" that only picks out patterns that we specify and lets the rest of the characters pass through without modification (and, more importantly, without needing to specify every nook and cranny of the incoming grammar).

3. `Extract Semantic Information` is, in this example code, implemented using the `Rewriter`. Maybe `jq` could have been used via a VSH call-out (`$`).  The idea is to filter the incoming JSON and to exhale only the few items we are interested in.

4. `Translate Cards to PROLOG` is, also, written using the `Rewriter`. Maybe `jq` could have been used. Maybe `jq` will be used in the next version of this code.

5. `Generate Markdown` is implemented in Prolog.

6. `Unescape Whitespace` is implemented as a VSH call-out to a node.js program (`rt/unescaped.js`.

Languages involved:
- Odin
- OhmJS
- RWR
- Prolog
- Javascript
- shell (?)
- markdown
- JSON
- Drawware0D


